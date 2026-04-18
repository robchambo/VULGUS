#!/usr/bin/env python3
"""Suggest novel 4-word groups for a given tag from the VULGUS lexicon.

Reads existing puzzles 001-100 to deduplicate and score candidates by
word reuse, shared-tag tightness, and region coherence.

Usage:
    py scripts/suggest_groups.py --tag "Shakespearean"
    py scripts/suggest_groups.py --tag "Nautical" --limit 20
    py scripts/suggest_groups.py --tag "Australian" --limit 5
"""

from __future__ import annotations
import argparse
import itertools
import json
import os
import random
import re
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
JSON_PATH = os.path.join(REPO, 'dictionary', 'vulgus_lexicon.json')
DATA_DIR = os.path.join(REPO, 'flutter_app', 'lib', 'game', 'data')

MAX_COMBOS = 10_000   # If more than this, random-sample instead
SAMPLE_SEED = 42


def _load_lexicon() -> list[dict]:
    with open(JSON_PATH, encoding='utf-8') as f:
        data = json.load(f)
    return data.get('words', [])


def _existing_groups() -> set[tuple[str, ...]]:
    """Return all 4-word groups from dart files 001-100 as sorted tuples."""
    groups: set[tuple[str, ...]] = set()
    for i in range(1, 101):
        p = os.path.join(DATA_DIR, f'vulgus_{i:03d}.dart')
        if not os.path.exists(p):
            continue
        body = open(p, encoding='utf-8').read()
        for m in re.findall(r'tiles:\s*\[(.*?)\]', body, re.DOTALL):
            words = re.findall(r"'([^']+)'", m)
            if len(words) == 4:
                groups.add(tuple(sorted(words)))
    return groups


def _word_usage_counts() -> dict[str, int]:
    """Count how many times each word appears across all 100 dart puzzle files."""
    counts: dict[str, int] = {}
    for i in range(1, 101):
        p = os.path.join(DATA_DIR, f'vulgus_{i:03d}.dart')
        if not os.path.exists(p):
            continue
        body = open(p, encoding='utf-8').read()
        for m in re.findall(r'tiles:\s*\[(.*?)\]', body, re.DOTALL):
            for w in re.findall(r"'([^']+)'", m):
                counts[w] = counts.get(w, 0) + 1
    return counts


def _score_candidate(
    combo: tuple[dict, ...],
    usage_counts: dict[str, int],
) -> tuple[float, int, int, int]:
    """Return a sort key (lower = better, so negate for descending sort).

    Components:
        max_reuse  — max usage count of any word in the combo (lower is better)
        shared_bonus — 1 if all 4 share >=2 tags, else 0
        region_bonus — 1 if all 4 share the same region, else 0
    Score = -max_reuse + shared_bonus + region_bonus  (higher = better)
    """
    words = [e['word'] for e in combo]
    max_reuse = max(usage_counts.get(w, 0) for w in words)

    # Shared-tag bonus: count tags shared by all 4
    tag_sets = [set(e.get('tags', [])) for e in combo]
    shared_tags = tag_sets[0].intersection(*tag_sets[1:])
    shared_bonus = 1 if len(shared_tags) >= 2 else 0

    # Region coherence bonus
    regions = {e.get('region', '') for e in combo}
    region_bonus = 1 if len(regions) == 1 else 0

    score = -max_reuse + shared_bonus + region_bonus
    return (-score, max_reuse, -shared_bonus, -region_bonus)   # sort ascending -> best first


def main():
    parser = argparse.ArgumentParser(
        description='Suggest novel 4-word groups for a VULGUS tag.'
    )
    parser.add_argument('--tag', required=True, help='Tag to filter words by')
    parser.add_argument('--limit', type=int, default=10, help='Number of results to show (default 10)')
    args = parser.parse_args()

    tag = args.tag
    limit = args.limit

    # Load data
    all_words = _load_lexicon()
    candidates = [
        e for e in all_words
        if e.get('ship', '').upper() == 'YES' and tag in e.get('tags', [])
    ]

    if len(candidates) < 4:
        print(f"Not enough words with ship=YES and tag {tag!r}: found {len(candidates)}, need >=4")
        sys.exit(1)

    existing = _existing_groups()
    usage_counts = _word_usage_counts()

    # Generate combinations
    n = len(candidates)
    from math import comb
    total_combos = comb(n, 4)

    if total_combos <= MAX_COMBOS:
        combos = list(itertools.combinations(candidates, 4))
    else:
        # Sample a subset
        random.seed(SAMPLE_SEED)
        all_combos = list(itertools.combinations(range(n), 4))
        sampled_indices = random.sample(all_combos, MAX_COMBOS)
        combos = [tuple(candidates[i] for i in idx) for idx in sampled_indices]

    # Filter out existing groups
    unique_combos = [
        combo for combo in combos
        if tuple(sorted(e['word'] for e in combo)) not in existing
    ]

    print(f'Candidates for tag "{tag}" ({n} words, {total_combos} combos, {len(unique_combos)} unique):\n')

    if not unique_combos:
        print('  (no unique candidates found)')
        sys.exit(0)

    # Score and sort
    unique_combos.sort(key=lambda combo: _score_candidate(combo, usage_counts))

    shown = unique_combos[:limit]
    for rank, combo in enumerate(shown, 1):
        words = [e['word'] for e in combo]
        max_reuse = max(usage_counts.get(w, 0) for w in words)

        tag_sets = [set(e.get('tags', [])) for e in combo]
        shared_tags = tag_sets[0].intersection(*tag_sets[1:])
        n_shared = len(shared_tags)

        regions = [e.get('region', '') for e in combo]
        all_same_region = len(set(regions)) == 1
        region_str = regions[0] if all_same_region else 'MIXED'

        print(f"  {rank}. {' / '.join(words)}")
        print(f"     Max reuse: {max_reuse}  Shared tags: {n_shared}  Region: {region_str}")


if __name__ == '__main__':
    main()
