#!/usr/bin/env python3
"""Merge a batch of new entries into the canonical lexicon.

Input: dictionary/curation/new_entries.json — list of partial entries.
Output: dictionary/vulgus_lexicon.json updated in place.

Each new entry must provide: word, definition, severity, region, era,
semantic_type, tags, etymology, source. Everything else is derived.
New entries ship as MAYBE until human-reviewed (editorial pipeline).
"""
from __future__ import annotations
import json, os, sys, datetime

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
JSON = os.path.join(REPO, 'dictionary', 'vulgus_lexicon.json')
NEW = os.path.join(REPO, 'dictionary', 'curation', 'new_entries.json')

POS_DEFAULT = {
    'exclamation': 'interj', 'minced-oath': 'interj', 'intensifier': 'adv',
    'euphemism': 'interj', 'religious': 'interj',
    'anatomy': 'noun', 'scatological': 'noun', 'nonsense': 'noun',
    'insult-mild': 'noun', 'fictional': 'interj',
}

def derive_register(severity: int, semantic: str, era: str) -> str:
    if era == 'archaic' or semantic == 'minced-oath':
        if semantic == 'minced-oath':
            return 'euphemism'
        return 'archaic'
    if semantic == 'euphemism':
        return 'euphemism'
    if severity >= 3:
        return 'vulgar'
    return 'informal'

def main():
    with open(JSON, encoding='utf-8') as f:
        lex = json.load(f)
    with open(NEW, encoding='utf-8') as f:
        new_entries = json.load(f)

    existing = {e['word'].lower() for e in lex['entries']}
    next_id = max(e['id'] for e in lex['entries']) + 1

    added = 0
    errors = []
    for n in new_entries:
        word = n['word'].strip()
        key = word.lower()
        if key in existing:
            errors.append(f"duplicate: {word!r} already in lexicon")
            continue
        for required in ('word', 'definition', 'severity', 'region', 'era',
                         'semantic_type', 'tags', 'etymology', 'source'):
            if required not in n:
                errors.append(f"{word!r}: missing field {required!r}")
        if errors:
            continue

        is_single = ' ' not in word and '-' not in word
        length = len(word.replace(' ', '').replace('-', ''))
        pos = n.get('part_of_speech') or POS_DEFAULT.get(n['semantic_type'], 'noun')
        if not is_single and not n.get('part_of_speech'):
            pos = 'phrase'
        severity = n['semantic_type'] and n['severity']
        register = n.get('register') or derive_register(
            n['severity'], n['semantic_type'], n['era'])
        ship = n.get('ship', 'MAYBE')
        wordle_eligible = (
            is_single and 4 <= length <= 7 and n['severity'] <= 3
            and ship == 'YES' and pos != 'phrase'
        )

        entry = {
            'id': next_id,
            'word': word,
            'variants': n.get('variants', []),
            'length': length,
            'is_single_word': is_single,
            'part_of_speech': pos,
            'definition': n['definition'].strip(),
            'etymology': n['etymology'].strip(),
            'first_attested': n.get('first_attested'),
            'severity': n['severity'],
            'region': n['region'],
            'era': n['era'],
            'semantic_type': n['semantic_type'],
            'tags': list(n['tags']),
            'register': register,
            'family': n.get('family'),
            'wordle_eligible': wordle_eligible,
            'license': n.get('license', 'fair-use-attribution'),
            'puzzle_difficulty': n.get('puzzle_difficulty', ''),
            'ship': ship,
            'reviewer_1': n.get('reviewer_1', ''),
            'reviewer_2': n.get('reviewer_2', ''),
            'date_approved': n.get('date_approved', ''),
            'source': n['source'],
            'notes': n.get('notes', 'Drafted for review — pass 3 expansion.'),
        }
        lex['entries'].append(entry)
        existing.add(key)
        next_id += 1
        added += 1

    if errors:
        print('ERRORS:')
        for e in errors:
            print(f'  - {e}')
        sys.exit(1)

    lex['entry_count'] = len(lex['entries'])
    with open(JSON, 'w', encoding='utf-8') as f:
        json.dump(lex, f, indent=2, ensure_ascii=False)
    print(f'added {added} entries; total now {lex["entry_count"]}')

if __name__ == '__main__':
    main()
