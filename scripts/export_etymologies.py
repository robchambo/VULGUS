#!/usr/bin/env python3
"""Export all category etymologies from puzzle dart files to a CSV spreadsheet."""

import csv
import os
import re

DATA_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                        'flutter_app', 'lib', 'game', 'data')
OUT = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                   'dictionary', 'category_etymologies.csv')


def unescape_dart(s: str) -> str:
    return s.replace("\\'", "'").replace("\\\\", "\\").replace('\\"', '"')


def extract_categories(filepath: str, puzzle_num: int):
    body = open(filepath, encoding='utf-8').read()
    # Split on PuzzleCategory( to isolate each category block
    blocks = re.split(r'PuzzleCategory\(', body)
    results = []
    for block in blocks[1:]:  # skip the preamble before first category
        def field(name):
            # Try single-quoted first, then double-quoted
            m = re.search(rf"{name}:\s*'((?:[^'\\]|\\.)*?)'", block, re.DOTALL)
            if m:
                return unescape_dart(m.group(1))
            m = re.search(rf'{name}:\s*"((?:[^"\\]|\\.)*?)"', block, re.DOTALL)
            if m:
                return unescape_dart(m.group(1))
            return ''

        cat_id = field('id')
        label = field('label')
        etymology = field('etymology')

        diff_m = re.search(r'difficulty:\s*Difficulty\.(\w+)', block)
        diff = diff_m.group(1).capitalize() if diff_m else ''

        tiles = re.findall(r"'([^']+)'", re.search(r'tiles:\s*\[(.*?)\]', block, re.DOTALL).group(1))

        results.append({
            'Puzzle': f'VULGUS-{puzzle_num:03d}',
            'Puzzle #': puzzle_num,
            'Category ID': cat_id,
            'Category Label': label,
            'Difficulty': diff,
            'Tiles': ' / '.join(tiles),
            'Etymology': etymology,
            'Word Count': len(etymology.split()) if etymology else 0,
        })
    return results


def main():
    rows = []
    for i in range(1, 51):
        path = os.path.join(DATA_DIR, f'vulgus_{i:03d}.dart')
        if not os.path.exists(path):
            continue
        rows.extend(extract_categories(path, i))

    with open(OUT, 'w', newline='', encoding='utf-8-sig') as f:
        w = csv.DictWriter(f, fieldnames=[
            'Puzzle', 'Puzzle #', 'Category ID', 'Category Label',
            'Difficulty', 'Tiles', 'Etymology', 'Word Count',
        ])
        w.writeheader()
        w.writerows(rows)

    print(f'Wrote {len(rows)} rows to {OUT}')


if __name__ == '__main__':
    main()
