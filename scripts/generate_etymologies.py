#!/usr/bin/env python3
"""Generate etymologies.dart from the canonical vulgus_lexicon.json.

vulgus_lexicon.json is the single source of truth (schema v0.3.0+).
etymologies.dart is a generated artifact and should never be hand-edited.

Usage:
    py scripts/generate_etymologies.py            # write the Dart file
    py scripts/generate_etymologies.py --check    # CI mode: exit 1 if drift

--check mode regenerates content in memory and compares against the on-disk
Dart file. Exits 0 if identical, 1 if different (drift detected).
"""

import json
import os
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LEXICON = os.path.join(REPO, 'dictionary', 'vulgus_lexicon.json')
OUT = os.path.join(REPO, 'flutter_app', 'lib', 'game', 'data', 'etymologies.dart')


def escape_dart(s: str) -> str:
    return s.replace('\\', '\\\\').replace("'", "\\'")


def render(data: dict) -> str:
    lines = [
        "class Etymology {",
        "  final String meta;",
        "  final String note;",
        "  const Etymology({required this.meta, required this.note});",
        "}",
        "",
        "const etymologies = <String, Etymology>{",
    ]

    for w in sorted(data['words'], key=lambda x: x['word']):
        word = w['word'].upper()
        note = w.get('etymology_note', '') or ''
        region = w.get('region', '') or ''
        era = w.get('era', '') or ''

        # Build meta from region + era
        meta_parts = []
        if region and region not in ('GLOBAL', ''):
            meta_parts.append(region)
        if era and era not in ('contemporary', ''):
            meta_parts.append(era)
        meta = ' \u00b7 '.join(meta_parts) if meta_parts else ''

        # Use etymology_note; fall back to definition
        if not note:
            note = w.get('definition', '') or 'Etymology pending.'

        lines.append(
            f"  '{escape_dart(word)}': Etymology("
            f"meta: '{escape_dart(meta)}', "
            f"note: '{escape_dart(note)}'),"
        )

    lines.append("};")
    lines.append("")
    return '\n'.join(lines)


def main():
    check_mode = '--check' in sys.argv[1:]

    with open(LEXICON, encoding='utf-8') as f:
        data = json.load(f)

    expected = render(data)

    if check_mode:
        try:
            with open(OUT, encoding='utf-8') as f:
                actual = f.read()
        except FileNotFoundError:
            print(f"DRIFT: {OUT} does not exist (run without --check to generate)")
            sys.exit(1)

        if actual == expected:
            print(f"OK: {OUT} is in sync with {LEXICON} ({len(data['words'])} entries)")
            sys.exit(0)
        else:
            print(
                f"DRIFT: {OUT} is out of sync with {LEXICON}.\n"
                f"Run `py scripts/generate_etymologies.py` to regenerate."
            )
            sys.exit(1)

    with open(OUT, 'w', encoding='utf-8') as f:
        f.write(expected)

    print(f"Wrote {len(data['words'])} etymology entries to {OUT}")


if __name__ == '__main__':
    main()
