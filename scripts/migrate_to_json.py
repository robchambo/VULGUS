#!/usr/bin/env python3
"""Migrate VULGUS_Dictionary_v0.1.xlsx to canonical vulgus_lexicon.json.

Pass 1+2 of the lexicon expansion plan: reads the xlsx source of truth,
computes enriched schema fields, and writes a schema-versioned JSON file.
"""

from __future__ import annotations
import json, os, re, sys, zipfile
import xml.etree.ElementTree as ET
from datetime import datetime, timezone

NS = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'
def _tag(n): return f'{{{NS}}}{n}'

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
XLSX = os.path.join(REPO, 'dictionary', 'VULGUS_Dictionary_v0.1.xlsx')
OUT  = os.path.join(REPO, 'dictionary', 'vulgus_lexicon.json')

# ── Sub-theme tag mapping ──────────────────────────────────────────────
SUB_THEME_TAGS: dict[str, list[str]] = {}
_tag_groups = {
    'yiddish-origin':   ['SCHMUCK', 'PUTZ', 'KLUTZ', 'BUBKES'],
    'military':         ['SNAFU', 'FUBAR', 'BOHICA', 'TARFU',
                         'CHARLIE FOXTROT', 'GOAT ROPE', 'SAD SACK',
                         'POGUE', 'CLUSTER'],
    'southern-us':      ['DAGNABBIT', 'TARNATION', 'CONSARN', 'CRIMINY'],
    'midwest-us':       ['OPE', 'UFF DA', "DON'T CHA KNOW", 'RECKON'],
    'frontier-us':      ['CATTYWAMPUS', 'HORNSWOGGLE', 'HOG-TIED',
                         'COCKAMAMIE', 'FLAPDOODLE'],
    'internet-era':     ['WACK', 'JANKY', 'SALTY', 'SHOOK', 'TRIPPIN',
                         'DISS', 'BUSTED', 'BOGUS'],
    'sci-fi-fictional': ['FRAK', 'SMEG', 'FRELL', 'GORRAM'],
    'celtic':           ['EEJIT', 'GOBSHITE', 'FECKIN', 'BAMPOT'],
    'australian':       ['DRONGO', 'GALAH', 'BOGAN'],
}
for tag, words in _tag_groups.items():
    for w in words:
        SUB_THEME_TAGS.setdefault(w, []).append(tag)

# ── Part-of-speech mapping ─────────────────────────────────────────────
POS_MAP = {
    'anatomy':        'noun',
    'insult-mild':    'noun',
    'insult-strong':  'noun',
    'exclamation':    'interjection',
    'euphemism':      'interjection',
    'intensifier':    'adjective',
    'nonsense':       'noun',
    'action':         'verb',
}

# ── Register mapping ──────────────────────────────────────────────────
REGISTER_MAP = {1: 'euphemism', 2: 'informal', 3: 'vulgar', 4: 'taboo', 5: 'taboo'}

# ── First-attested parsing ─────────────────────────────────────────────
_YEAR_RE     = re.compile(r'\b(1[0-9]{3}|20[0-2][0-9])\b')
_DECADE_RE   = re.compile(r'\b(1[0-9]{3}|20[0-2][0-9])s\b')
_CENTURY_MAP = {
    '14th': 1350, '15th': 1450, '16th': 1550, '17th': 1650,
    '18th': 1750, '19th': 1850, '20th': 1920, '21st': 2000,
}
_CENTURY_RE  = re.compile(r'\b(1[4-9]th|2[01]st|20th)\s*[Cc]', re.IGNORECASE)


def _parse_first_attested(etym: str) -> int | None:
    if not etym:
        return None
    low = etym.lower()
    if 'old english' in low:
        return 900
    if 'middle english' in low:
        return 1350
    m = _CENTURY_RE.search(etym)
    if m:
        return _CENTURY_MAP.get(m.group(1).lower(), None)
    m = _DECADE_RE.search(etym)
    if m:
        return int(m.group(1))
    m = _YEAR_RE.search(etym)
    if m:
        return int(m.group(1))
    return None


# ── Definition from etymology ──────────────────────────────────────────
def _make_definition(etym: str) -> str:
    if not etym:
        return ''
    # Take first sentence/clause (split on ; or . or —)
    for sep in ['. ', '; ', ' — ', ' – ']:
        idx = etym.find(sep)
        if idx != -1:
            candidate = etym[:idx].strip()
            if len(candidate) > 10:
                return candidate[:120]
    return etym[:120]


# ── License mapping ───────────────────────────────────────────────────
def _derive_license(source: str) -> str:
    s = source.lower()
    if 'oed' in s or 'etymonline' in s:
        return 'fair-use-attribution'
    if 'wiktionary' in s:
        return 'CC-BY-SA'
    return 'public-domain'


# ── Read xlsx (same zipfile+xml pattern as generate_puzzles.py) ────────
def _read_xlsx(path: str) -> list[dict]:
    with zipfile.ZipFile(path) as z:
        with z.open('xl/sharedStrings.xml') as f:
            ss = [''.join(p.text or '' for p in si.findall(f'.//{_tag("t")}'))
                  for si in ET.parse(f).getroot().findall(f'.//{_tag("si")}')]
        with z.open('xl/workbook.xml') as f:
            sheets = {s.get('name'): int(s.get('sheetId'))
                      for s in ET.parse(f).getroot().findall(f'.//{_tag("sheet")}')}
        with z.open(f'xl/worksheets/sheet{sheets["Dictionary"]}.xml') as f:
            ws = ET.parse(f)
    rows = ws.getroot().findall(f'.//{_tag("row")}')
    def cv(c):
        t = c.get('t'); v = c.find(_tag('v'))
        if v is None: return ''
        return ss[int(v.text)] if t == 's' else (v.text or '')
    hdrs = [cv(c) for c in rows[0].findall(_tag('c'))]
    out = []
    for r in rows[1:]:
        vals = [cv(c) for c in r.findall(_tag('c'))]
        while len(vals) < len(hdrs): vals.append('')
        d = dict(zip(hdrs, vals))
        if d.get('Word', '').strip():
            out.append(d)
    return out


def _transform(row: dict) -> dict:
    word = row.get('Word', '').strip().upper()
    variants_raw = row.get('Variants', '').strip()
    variants = [v.strip() for v in variants_raw.split('|') if v.strip()] if variants_raw else []
    severity = int(row.get('Severity (1-5)', '0') or '0')
    region = row.get('Region', '').strip()
    era = row.get('Era', '').strip()
    semantic_type = row.get('Semantic Type', '').strip()
    etym = row.get('Etymology Note', '').strip()
    puzzle_diff = row.get('Puzzle Difficulty (Y/B/R/K)', '').strip()
    ship = row.get('Ship (YES/NO/MAYBE)', '').strip().upper()
    reviewer_1 = row.get('Reviewer 1', '').strip()
    reviewer_2 = row.get('Reviewer 2', '').strip()
    date_approved = row.get('Date Approved', '').strip()
    source = row.get('Source', '').strip()
    notes = row.get('Notes', '').strip()

    # Tags: collapse Category 1-4 + sub-theme tags
    tags = []
    for i in range(1, 5):
        cat = row.get(f'Category {i}', '').strip()
        if cat and cat not in tags:
            tags.append(cat)
    for st in SUB_THEME_TAGS.get(word, []):
        if st not in tags:
            tags.append(st)

    # Computed fields
    length = len(word.replace(' ', ''))
    is_single_word = ' ' not in word
    part_of_speech = POS_MAP.get(semantic_type, 'interjection')
    definition = _make_definition(etym)
    first_attested = _parse_first_attested(etym)
    register = REGISTER_MAP.get(severity, 'informal')
    wordle_eligible = (is_single_word and length in {4, 5, 6, 7}
                       and severity <= 3 and ship == 'YES')
    license_ = _derive_license(source)

    return {
        'id': int(row.get('ID', '0') or '0'),
        'word': word,
        'variants': variants,
        'severity': severity,
        'region': region,
        'era': era,
        'semantic_type': semantic_type,
        'tags': tags,
        'etymology_note': etym,
        'puzzle_difficulty': puzzle_diff,
        'ship': ship,
        'reviewer_1': reviewer_1,
        'reviewer_2': reviewer_2,
        'date_approved': date_approved,
        'source': source,
        'notes': notes,
        'length': length,
        'is_single_word': is_single_word,
        'part_of_speech': part_of_speech,
        'definition': definition,
        'first_attested': first_attested,
        'register': register,
        'family': None,
        'wordle_eligible': wordle_eligible,
        'license': license_,
    }


def main():
    if not os.path.exists(XLSX):
        print(f'ERROR: {XLSX} not found'); sys.exit(1)

    rows = _read_xlsx(XLSX)
    print(f'Read {len(rows)} words from xlsx.')

    words = [_transform(r) for r in rows]

    # Sort by id
    words.sort(key=lambda w: w['id'])

    wordle_count = sum(1 for w in words if w['wordle_eligible'])

    doc = {
        'schema_version': '0.2.0',
        'generated_from': 'VULGUS_Dictionary_v0.1.xlsx',
        'generated_at': datetime.now(timezone.utc).isoformat(),
        'word_count': len(words),
        'words': words,
    }

    with open(OUT, 'w', encoding='utf-8') as f:
        json.dump(doc, f, ensure_ascii=False, indent=2)

    print(f'Wrote {OUT}')
    print(f'  Words:          {len(words)}')
    print(f'  Wordle-eligible: {wordle_count}')

    # Spot checks
    by_word = {w['word']: w for w in words}
    checks = []

    b = by_word.get('BOLLOCKS')
    if b:
        checks.append(('BOLLOCKS length=8', b['length'] == 8))
        checks.append(('BOLLOCKS is_single_word=True', b['is_single_word'] is True))
        checks.append(('BOLLOCKS wordle_eligible=False', b['wordle_eligible'] is False))

    d = by_word.get('DAMN')
    if d:
        checks.append(('DAMN length=4', d['length'] == 4))
        checks.append(('DAMN is_single_word=True', d['is_single_word'] is True))
        checks.append(('DAMN wordle_eligible=True', d['wordle_eligible'] is True))

    hc = by_word.get('HOLY COW')
    if hc:
        checks.append(('HOLY COW is_single_word=False', hc['is_single_word'] is False))
        checks.append(('HOLY COW wordle_eligible=False', hc['wordle_eligible'] is False))

    for label, ok in checks:
        status = 'PASS' if ok else 'FAIL'
        print(f'  [{status}] {label}')

    if not all(ok for _, ok in checks):
        print('ERROR: Some spot checks failed!'); sys.exit(1)


if __name__ == '__main__':
    main()
