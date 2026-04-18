#!/usr/bin/env python3
"""Generate etymologies.dart from the canonical vulgus_lexicon.json.

Replaces the hand-written etymologies.dart with entries for ALL words
in the lexicon, so every puzzle tile has a real etymology reveal.
"""

import json
import os

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LEXICON = os.path.join(REPO, 'dictionary', 'vulgus_lexicon.json')
OUT = os.path.join(REPO, 'flutter_app', 'lib', 'game', 'data', 'etymologies.dart')


def escape_dart(s: str) -> str:
    return s.replace('\\', '\\\\').replace("'", "\\'")


def main():
    with open(LEXICON, encoding='utf-8') as f:
        data = json.load(f)

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

    with open(OUT, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))

    print(f"Wrote {len(data['words'])} etymology entries to {OUT}")


if __name__ == '__main__':
    main()
