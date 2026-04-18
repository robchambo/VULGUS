#!/usr/bin/env python3
"""Generate VULGUS puzzle dart files 031-050.

Reads the dictionary xlsx, validates hand-designed puzzle groupings,
and writes dart source files matching the existing pattern.
Re-runnable: overwrites targets each run.
"""

from __future__ import annotations
import argparse
import os, re, sys, zipfile
import xml.etree.ElementTree as ET

NS = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'
def _tag(n): return f'{{{NS}}}{n}'

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
XLSX = os.path.join(REPO, 'dictionary', 'VULGUS_Dictionary_v0.1.xlsx')
DATA_DIR = os.path.join(REPO, 'flutter_app', 'lib', 'game', 'data')

# Puzzle definitions: (id, title, [(cat_id, label, letter, tiles, etymology_override?)])
# Letter controls colour + difficulty: Y easy, B medium, R hard, K trickiest.
# etymology_override is optional; if omitted, pulled from first tile's dict entry.
PUZZLES = [
    (31, 'Holy Mackerel', [
        ('holy', '"Holy ___" surprises', 'Y',
         ['HOLY COW', 'HOLY MOLY', 'HOLY SMOKES', 'HOLY MACKEREL'],
         'American euphemisms for "holy sh*t" — religious taboo avoidance via animal/marine swap-ins.'),
        ('minced-jesus', 'Minced "Jesus"', 'B',
         ['GEE', 'GOLLY', 'JEEPERS', 'JIMINY'], None),
        ('archaic-brit', 'Archaic British oaths', 'R',
         ['EGAD', 'ZOUNDS', 'GADZOOKS', 'CRIPES'], None),
        ('southern-oaths', 'Southern US oaths', 'K',
         ['DAGNABBIT', 'TARNATION', 'CRIMINY', 'SAKES'], None),
    ]),
    (32, 'The Stand-Ins', [
        ('food-sub', 'Food-based substitutes', 'Y',
         ['SUGAR', 'FUDGE', 'PEANUT', 'GOOBER'],
         'American tradition: swap a sweary word for a food-word of roughly the same shape.'),
        ('mild-us', 'Mild American stand-ins', 'B',
         ['SHOOT', 'DANG', 'DARN', 'HECK'], None),
        ('scifi', 'Made-up swears', 'R',
         ['FRAK', 'SMEG', 'DOOZY', 'GORRAM'],
         'Invented to sound sweary without being sweary — some from TV, others just creative linguistic dodges.'),
        ('elaborate', 'Elaborate avoidances', 'K',
         ['FIDDLE-FADDLE', 'FIDDLESTICKS', 'BUSHWA', 'HORSEFEATHERS'],
         'The longer the euphemism, the further from the actual swear — Victorian-style padding.'),
    ]),
    (33, 'Idiots International', [
        ('brit-fool', 'British fools', 'Y',
         ['WALLY', 'PILLOCK', 'PLONKER', 'MUPPET'], None),
        ('us-fool', 'American fools', 'B',
         ['DOOFUS', 'DINGBAT', 'DIPSTICK', 'KLUTZ'], None),
        ('aus-fool', 'Australian fools', 'R',
         ['DRONGO', 'GALAH', 'BOGAN', 'PALOOKA'],
         'Australian English, often drawn from native bird names or anglicised imports.'),
        ('celtic-fool', 'Celtic fools', 'K',
         ['EEJIT', 'BAMPOT', 'NUMPTY', 'GOBSHITE'], None),
    ]),
    (34, 'Rogues\' Gallery', [
        ('animal', 'Animal-based insults', 'Y',
         ['COW', 'PIG', 'JACKASS', 'DRONGO'],
         'When you want to call someone an animal, pick one.'),
        ('archaic', 'Rogues & rascals', 'B',
         ['VARLET', 'KNAVE', 'SCOUNDREL', 'POGUE'], None),
        ('yiddish', 'Yiddish-origin contempt', 'R',
         ['SCHMUCK', 'PUTZ', 'NIMROD', 'YAHOO'],
         'American English loanwords — Yiddish immigrant communities and Swiftian coinages.'),
        ('us-political', 'Political scoundrels', 'K',
         ['SNOLLYGOSTER', 'MOUNTEBANK', 'CRAPPER', 'BOHICA'],
         'American political English: from the 19th C "snollygoster" onward, a rich tradition.'),
    ]),
    (35, 'All Rot', [
        ('short-rot', 'Blunt rubbish', 'Y',
         ['TOSH', 'HOGWASH', 'HOOEY', 'CRUD'], None),
        ('vic-rot', 'Victorian rubbish', 'B',
         ['POPPYCOCK', 'BALDERDASH', 'CODSWALLOP', 'CLAPTRAP'], None),
        ('us-rot', 'American rubbish', 'R',
         ['MALARKEY', 'BALONEY', 'BUBKES', 'BUNKUM'], None),
        ('frontier-rot', 'Frontier nonsense', 'K',
         ['FLAPDOODLE', 'HORNSWOGGLE', 'CATTYWAMPUS', 'COCKAMAMIE'], None),
    ]),
    (36, 'Body Politic II', [
        ('anatomy', 'Anatomical swears', 'Y',
         ['ARSE', 'BUM', 'BOLLOCKS', 'KNACKERS'], None),
        ('body-euph', 'Body-part euphemisms', 'B',
         ['DORK', 'DIPSTICK', 'PILLOCK', 'SCHMUCK'],
         'All four originate as slang for anatomy before shifting to "idiot."'),
        ('head-comp', 'Head compounds', 'R',
         ['BONEHEAD', 'MEATHEAD', 'LUNKHEAD', 'KNUCKLEHEAD'], None),
        ('hard-body', 'Strong body-origin words', 'K',
         ['WANKER', 'BUGGER', 'BERK', 'CRAPPER'],
         "All four trace to anatomy or bodily acts, now varying in sting."),
    ]),
    (37, 'What\'s in a Name?', [
        ('eponyms', 'Named after people/places', 'Y',
         ['BUNKUM', 'NIMROD', 'CRAPPER', 'MOUNTEBANK'],
         '"Bunkum" — Buncombe County NC; "Nimrod" — biblical hunter; "Crapper" — Thomas Crapper the plumber; "mountebank" — Italian "monta in banco" (climb on a bench).'),
        ('scifi-coin', 'Coinages & inventions', 'B',
         ['FRAK', 'SMEG', 'CRUD', 'GORRAM'],
         'Words coined or repurposed to fill the sweary gap — some from TV, one from good old English.'),
        ('animal-insult', 'Animal-name insults', 'R',
         ['GALAH', 'TURKEY', 'BOGAN', 'BOGUS'],
         '"Galah" — a pink cockatoo; "turkey" — the country; "bogan" — possibly from Bogan River; "bogus" — origin obscure.'),
        ('us-coin', 'American coinages', 'K',
         ['SNOLLYGOSTER', 'COCKAMAMIE', 'MALARKEY', 'BALONEY'],
         '19th – 20th C American English inventions of uncertain etymology.'),
    ]),
    (38, 'Foreign Affairs', [
        ('yiddish', 'From Yiddish', 'Y',
         ['SCHMUCK', 'PUTZ', 'KLUTZ', 'BUBKES'],
         'Yiddish-origin American English: "shmok" (penis), "pots" (penis), "klots" (block of wood), "beytsim" (eggs).'),
        ('celtic', 'From Irish/Scots Gaelic', 'B',
         ['EEJIT', 'BAMPOT', 'FECKIN', 'NUMPTY'], None),
        ('vic-brit', 'Victorian British', 'R',
         ['POPPYCOCK', 'CODSWALLOP', 'BALDERDASH', 'TWADDLE'], None),
        ('mil-acr', 'Military acronyms', 'K',
         ['SNAFU', 'FUBAR', 'BOHICA', 'CHARLIE FOXTROT'], None),
    ]),
    (39, 'Down South', [
        ('midwest', 'Regional Americana', 'Y',
         ['OPE', 'RECKON', 'UFF DA', 'DON\'T CHA KNOW'],
         'Distinct regional Americanisms — Midwest "ope," Southern "reckon," Scandinavian-American "uff da," Minnesotan "don\'t cha know."'),
        ('southern-oath', 'Southern oaths', 'B',
         ['DAGNABBIT', 'TARNATION', 'CONSARN', 'CRIMINY'], None),
        ('frontier', 'Frontier imagery', 'R',
         ['HOG-TIED', 'HORNSWOGGLE', 'CATTYWAMPUS', 'COCKAMAMIE'], None),
        ('southern-phrase', 'Southern phrases', 'K',
         ['BLESS YOUR HEART', 'HEAVENS TO BETSY', 'MERCY ME', 'CHEESE AND RICE'],
         'Southern US phrases — politeness, shock, and passive aggression in roughly equal measure.'),
    ]),
    (40, 'Goat Rope', [
        ('mil-acr', 'Military acronyms', 'Y',
         ['SNAFU', 'FUBAR', 'POGUE', 'TARFU'], None),
        ('mil-mess', 'Military words for a mess', 'B',
         ['GOAT ROPE', 'CHARLIE FOXTROT', 'SAD SACK', 'CLUSTER'],
         'US military slang — a "goat rope" or "charlie foxtrot" is a chaotic operation; a "sad sack" is the unfortunate soul stuck in it.'),
        ('modern-fail', 'Modern slang', 'R',
         ['WACK', 'JANKY', 'BUSTED', 'CRUD'], None),
        ('emo-state', 'Emotional-state slang', 'K',
         ['SALTY', 'SHOOK', 'TRIPPIN', 'DISS'], None),
    ]),
    (41, 'Strong Medicine', [
        ('strong-brit', 'Classic strong British', 'Y',
         ['BLOODY', 'BUGGER', 'ARSE', 'BOLLOCKS'], None),
        ('ptier-brit', 'Top-shelf British', 'B',
         ['WANKER', 'GOBSHITE', 'KNACKERS', 'COW'],
         'The sharper end of British vocabulary.'),
        ('celtic-strong', 'Celtic strength', 'R',
         ['FECKIN', 'EEJIT', 'BAMPOT', 'GORRAM'],
         'Irish/Scots minced swears — "feckin" is the Irish "f***ing" substitute.'),
        ('intensifiers', 'American intensifiers', 'K',
         ['DAMN', 'HELLFIRE', 'BEJESUS', 'WICKED'], None),
    ]),
    (42, 'Name That Fool', [
        ('heads', 'The -HEAD crew', 'Y',
         ['BONEHEAD', 'MEATHEAD', 'CHUCKLEHEAD', 'KNUCKLEHEAD'], None),
        ('nerdy', 'Nerdy fools', 'B',
         ['DORK', 'DWEEB', 'GOOBER', 'KOOK'], None),
        ('us-crossover', 'American fools', 'R',
         ['DINGBAT', 'DIPSTICK', 'DOOFUS', 'NUMPTY'], None),
        ('brit-idiot', 'British "idiot" words', 'K',
         ['NITWIT', 'TWIT', 'WALLY', 'PLONKER'], None),
    ]),
    (43, 'What a Mess', [
        ('mil-mess', 'Military-grade chaos', 'Y',
         ['SNAFU', 'CLUSTER', 'GOAT ROPE', 'CHARLIE FOXTROT'],
         'US military slang for operations that have gone sideways.'),
        ('people-mess', 'People in a mess', 'B',
         ['SAD SACK', 'POGUE', 'PALOOKA', 'YAHOO'], None),
        ('internet-fail', 'Internet-age slang', 'R',
         ['WACK', 'SHOOK', 'BUSTED', 'BOGUS'], None),
        ('old-mess', 'Old-school chaos', 'K',
         ['BALDERDASH', 'HOG-TIED', 'COCKAMAMIE', 'HORNSWOGGLE'], None),
    ]),
    (44, 'The Swerve', [
        ('gen-z', 'Gen-Z disapproval', 'Y',
         ['WACK', 'JANKY', 'SALTY', 'SHOOK'], None),
        ('internet', 'Internet-era verbs', 'B',
         ['TRIPPIN', 'DISS', 'BUSTED', 'BOGUS'], None),
        ('regional', 'Regional curios', 'R',
         ['OPE', 'RECKON', 'WICKED', 'HOG-TIED'],
         'Distinct regional US speech markers — Midwest "ope," Southern "reckon," Bostonian "wicked," Western "hog-tied."'),
        ('us-phrases', 'US exclamation phrases', 'K',
         ['GEEZ LOUISE', 'SON OF A GUN', 'FOR PETE\'S SAKE', 'I\'LL BE'],
         'Full-phrase American mild swears — rhyming, quasi-religious, or just long enough to be safe.'),
    ]),
    (45, 'The Mild Bunch', [
        ('short-mild', 'Short & mild', 'Y',
         ['DRAT', 'RATS', 'DANG', 'CRUD'], None),
        ('exclam', 'Exclamations', 'B',
         ['SHUCKS', 'PHOOEY', 'GOLLY', 'GOSH'], None),
        ('brit-mild', 'British mild', 'R',
         ['CRIKEY', 'BLIMEY', 'CRIPES', 'EGAD'], None),
        ('jesus-mild', 'Jesus-derived mild', 'K',
         ['JEEPERS', 'GEE', 'JIMINY', 'BEJESUS'], None),
    ]),
    (46, 'Pub Chatter', [
        ('pub-swear', 'Pub swears', 'Y',
         ['BUGGER', 'BLOODY', 'BLIMEY', 'CRIKEY'], None),
        ('pub-body', 'Pub anatomy', 'B',
         ['ARSE', 'CRAPPER', 'KNACKERS', 'BOLLOCKS'], None),
        ('pub-idiot', 'Pub words for idiot', 'R',
         ['NUMPTY', 'WALLY', 'PLONKER', 'PILLOCK'], None),
        ('pub-strong', 'Pub strong words', 'K',
         ['WANKER', 'GOBSHITE', 'BOGAN', 'BERK'], None),
    ]),
    (47, 'Trash Talk', [
        ('us-nerd', 'US nerd insults', 'Y',
         ['KOOK', 'NIMROD', 'DWEEB', 'DORK'], None),
        ('us-fool2', 'US fools', 'B',
         ['DOOFUS', 'DINGBAT', 'DIPSTICK', 'PALOOKA'], None),
        ('us-animal', 'US animal insults', 'R',
         ['TURKEY', 'JACKASS', 'PIG', 'COW'], None),
        ('us-dismiss', 'US dismissals', 'K',
         ['BOGUS', 'POGUE', 'SAD SACK', 'CLUSTER'], None),
    ]),
    (48, 'Old-Fashioned', [
        ('arch-oath', 'Archaic oaths', 'Y',
         ['ZOUNDS', 'GADZOOKS', 'EGAD', 'CONSARN'], None),
        ('arch-villain', 'Archaic villains', 'B',
         ['VARLET', 'KNAVE', 'SCOUNDREL', 'MOUNTEBANK'], None),
        ('vic-rot', 'Victorian rubbish', 'R',
         ['POPPYCOCK', 'BALDERDASH', 'TWADDLE', 'HUMBUG'], None),
        ('arch-us', 'Archaic Americana', 'K',
         ['SNOLLYGOSTER', 'CATTYWAMPUS', 'HORNSWOGGLE', 'FLAPDOODLE'], None),
    ]),
    (49, 'Parting Shot', [
        ('mild-one', 'Mild one-worders', 'Y',
         ['DARN', 'DRAT', 'RATS', 'SHUCKS'],
         'The softest of the soft — safe for grandma, the office, and live television.'),
        ('us-excl', 'American exclamation phrases', 'B',
         ['GEEZ LOUISE', 'FOR CRYIN\' OUT LOUD', 'SON OF A GUN', 'I\'LL BE'],
         'Multi-word American phrases — each a long detour around something shorter and stronger.'),
        ('southern-send', 'Southern send-offs', 'R',
         ['BLESS YOUR HEART', 'HEAVENS TO BETSY', 'MERCY ME', 'TARNATION'],
         'Southern US: politeness, shock, and passive aggression in roughly equal measure.'),
        ('midwest-mark', 'Midwest markers', 'K',
         ['UFF DA', 'DON\'T CHA KNOW', 'CHEESE AND RICE', 'OPE'],
         'Scandinavian-American "uff da," Minnesotan "don\'t cha know," and the universal Midwest "ope."'),
    ]),
    (50, 'Grand Finale II', [
        ('classics', 'British classics', 'Y',
         ['BLOODY', 'BLIMEY', 'ARSE', 'BUGGER'], None),
        ('us-classics', 'American classics', 'B',
         ['DAMN', 'HECK', 'CRAP', 'DANG'], None),
        ('phrase-classics', 'Full-phrase swears', 'R',
         ['HOLY MACKEREL', 'SON OF A GUN', 'BLESS YOUR HEART', 'GOAT ROPE'],
         'Multi-word American idioms that each stand in for something shorter and sharper.'),
        ('archaic', 'The archaics', 'K',
         ['ZOUNDS', 'VARLET', 'SNOLLYGOSTER', 'BUSHWA'], None),
    ]),
]

LETTER_TO_COLOUR = {
    'Y': ('AppColors.secondaryContainer', 'Difficulty.easy'),
    'B': ('AppColors.tertiary', 'Difficulty.medium'),
    'R': ('AppColors.primary', 'Difficulty.hard'),
    'K': ('AppColors.onSurface', 'Difficulty.trickiest'),
}


def _read_xlsx(path):
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
        if any(vals): out.append(dict(zip(hdrs, vals)))
    return out


def _existing_groups():
    groups = set()
    for i in range(1, 31):
        p = os.path.join(DATA_DIR, f'vulgus_{i:03d}.dart')
        if not os.path.exists(p): continue
        body = open(p).read()
        for m in re.findall(r'tiles:\s*\[(.*?)\]', body, re.DOTALL):
            t = tuple(sorted(re.findall(r"'([^']+)'", m)))
            if len(t) == 4: groups.add(t)
    return groups


def _escape_dart(s: str) -> str:
    return s.replace('\\', '\\\\').replace("'", "\\'")


def _render_category(cat_id, label, letter, tiles, etymology):
    colour, diff = LETTER_TO_COLOUR[letter]
    tile_list = ', '.join(f"'{_escape_dart(t)}'" for t in tiles)
    return (
        "    PuzzleCategory(\n"
        f"      id: '{cat_id}',\n"
        f"      label: '{_escape_dart(label)}',\n"
        f"      etymology: '{_escape_dart(etymology)}',\n"
        f"      color: {colour},\n"
        f"      difficulty: {diff},\n"
        f"      tiles: [{tile_list}],\n"
        "    ),\n"
    )


def _render_puzzle(n, title, categories, words_by_dict):
    lines = [
        "import '../models/difficulty.dart';\n",
        "import '../models/puzzle.dart';\n",
        "import '../models/puzzle_category.dart';\n",
        "import '../../theme/app_colors.dart';\n",
        "\n",
        f"// {title}\n",
        f"const vulgus{n:03d} = Puzzle(\n",
        f"  id: 'VULGUS-{n:03d}',\n",
        "  categories: [\n",
    ]
    for cat_id, label, letter, tiles, etym_override in categories:
        etym = etym_override
        if etym is None:
            # Pull from first tile's dictionary entry
            first = tiles[0].lower()
            etym = words_by_dict.get(first, {}).get('Etymology Note', '') or \
                   f'Part of the {label.lower()} group.'
        lines.append(_render_category(cat_id, label, letter, tiles, etym))
    lines.append("  ],\n);\n")
    return ''.join(lines)


def _render_library():
    out = ["import '../models/puzzle.dart';\n"]
    for i in range(1, 51):
        out.append(f"import 'vulgus_{i:03d}.dart';\n")
    out.append('\n')
    out.append('const List<Puzzle> puzzleLibrary = [\n')
    for i in range(1, 51):
        out.append(f'  vulgus{i:03d},\n')
    out.append('];\n')
    return ''.join(out)


def main():
    dict_rows = _read_xlsx(XLSX)
    # Normalise: key by lowercase word, allow YES/MAYBE only.
    words_by_dict = {}
    valid_words = set()
    for r in dict_rows:
        w = (r.get('Word') or '').strip()
        ship = (r.get('Ship (YES/NO/MAYBE)') or '').upper()
        if not w or ship not in ('YES', 'MAYBE'): continue
        key = w.lower()
        words_by_dict[key] = r
        valid_words.add(w.upper())

    existing = _existing_groups()
    print(f"Loaded {len(valid_words)} valid words, {len(existing)} existing groups.")

    errors = []
    new_groups = set()
    for (n, title, cats) in PUZZLES:
        seen_in_puzzle = set()
        for (cat_id, label, letter, tiles, _etym) in cats:
            if len(tiles) != 4:
                errors.append(f"puzzle {n} category {cat_id}: need 4 tiles, got {len(tiles)}")
            group = tuple(sorted(tiles))
            if group in existing:
                errors.append(f"puzzle {n} category {cat_id}: group collides with existing 001-030: {list(group)}")
            if group in new_groups:
                errors.append(f"puzzle {n} category {cat_id}: group collides with another new puzzle: {list(group)}")
            new_groups.add(group)
            for t in tiles:
                up = t.upper()
                if up not in valid_words:
                    errors.append(f"puzzle {n} category {cat_id}: tile {t!r} not in dictionary")
                if up in seen_in_puzzle:
                    errors.append(f"puzzle {n}: duplicate tile within puzzle: {up}")
                seen_in_puzzle.add(up)

    if errors:
        print("VALIDATION FAILED:")
        for e in errors: print(f"  - {e}")
        sys.exit(1)

    # Write puzzle files
    for (n, title, cats) in PUZZLES:
        dart = _render_puzzle(n, title, cats, words_by_dict)
        path = os.path.join(DATA_DIR, f'vulgus_{n:03d}.dart')
        with open(path, 'w', encoding='utf-8') as f:
            f.write(dart)

    # Write library
    lib = _render_library()
    with open(os.path.join(DATA_DIR, 'puzzle_library.dart'), 'w', encoding='utf-8') as f:
        f.write(lib)

    print(f"OK: wrote {len(PUZZLES)} puzzles, 0 collisions, {len(PUZZLES)}/{len(PUZZLES)} passed validation.")

    parser = argparse.ArgumentParser()
    parser.add_argument('--reuse-budget', type=int, default=None)
    args = parser.parse_args()

    if args.reuse_budget:
        counts = _count_word_usage(PUZZLES, DATA_DIR, range(1, 101))
        over = {w: c for w, c in counts.items() if c >= args.reuse_budget}
        if over:
            print(f"\nREUSE WARNING (budget={args.reuse_budget}):")
            for w, c in sorted(over.items(), key=lambda x: -x[1]):
                print(f"  {w}: {c} uses")
        else:
            print(f"\nAll words within reuse budget of {args.reuse_budget}.")


def _count_word_usage(puzzles_list, existing_dart_dir, existing_range):
    """Count per-word usage across existing dart files + new puzzles."""
    counts = {}
    # Count from existing dart files
    for i in existing_range:
        p = os.path.join(existing_dart_dir, f'vulgus_{i:03d}.dart')
        if not os.path.exists(p):
            continue
        body = open(p, encoding='utf-8').read()
        for m in re.findall(r"tiles:\s*\[(.*?)\]", body, re.DOTALL):
            for w in re.findall(r"'([^']+)'", m):
                counts[w] = counts.get(w, 0) + 1
    # Count from new puzzles
    for (n, title, cats) in puzzles_list:
        for (cat_id, label, letter, tiles, _) in cats:
            for w in tiles:
                counts[w] = counts.get(w, 0) + 1
    return counts


if __name__ == '__main__':
    main()
