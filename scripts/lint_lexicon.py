#!/usr/bin/env python3
"""Schema validation for dictionary/vulgus_lexicon.json.

Checks every word entry for required fields, valid values, internal
consistency, and cross-entry constraints (duplicate words/IDs).

Usage:
    py scripts/lint_lexicon.py
Exit 0 if clean, exit 1 if any errors found.
"""

from __future__ import annotations
import json
import os
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
JSON_PATH = os.path.join(REPO, 'dictionary', 'vulgus_lexicon.json')

VALID_SHIP = {'YES', 'NO', 'MAYBE'}
VALID_REGIONS = {'UK', 'US', 'AU', 'IE', 'SCO', 'GLOBAL', 'ARCHAIC', 'FICTIONAL'}
REQUIRED_FIELDS = [
    'id', 'word', 'severity', 'region', 'ship', 'tags',
    'etymology_note', 'definition', 'length', 'is_single_word',
    'register', 'wordle_eligible',
    # v0.3.0: tone toggle gates
    'tame_ok', 'filthy_ok',
]
WORDLE_ELIGIBLE_LENGTHS = {4, 5, 6, 7}

# Optional, gitignored. If present, every word/variant is checked against it.
# See dictionary/slur_blocklist.example.txt for format.
BLOCKLIST_PATH = os.path.join(REPO, 'dictionary', 'slur_blocklist.txt')


def default_tame_ok(severity: int) -> bool:
    """Default tame eligibility: severity 1-3 in, 4-5 out (override per word allowed)."""
    return severity <= 3


def default_filthy_ok(severity: int) -> bool:
    """Default filthy eligibility: every severity allowed."""
    return True


def load_blocklist() -> set[str] | None:
    """Load slur blocklist from disk. Returns None if file absent."""
    if not os.path.exists(BLOCKLIST_PATH):
        return None
    terms: set[str] = set()
    with open(BLOCKLIST_PATH, encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            terms.add(line.upper())
    return terms


def _is_empty(v) -> bool:
    """Return True if the value counts as empty/null."""
    if v is None:
        return True
    if isinstance(v, str) and not v.strip():
        return True
    return False


def lint(path: str) -> tuple[list[str], list[str]]:
    """Returns (errors, warnings). Errors fail the lint; warnings inform only."""
    errors: list[str] = []
    warnings: list[str] = []

    try:
        with open(path, encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        return [f"[file] Cannot load JSON: {e}"], warnings

    # Check 11: schema_version present
    if 'schema_version' not in data:
        errors.append("[file] Missing top-level 'schema_version' field")

    words_list = data.get('words', [])
    if not isinstance(words_list, list):
        return errors + ["[file] 'words' key is not a list"], warnings

    blocklist = load_blocklist()
    if blocklist is None:
        warnings.append(
            f"[file] Slur blocklist not found at {BLOCKLIST_PATH}. "
            f"Lint will not enforce slur exclusion. "
            f"See dictionary/slur_blocklist.example.txt for format."
        )

    seen_words: dict[str, int] = {}   # word -> first entry index
    seen_ids: dict[int | str, int] = {}  # id -> first entry index

    for idx, entry in enumerate(words_list):
        word = entry.get('word', '') or ''
        label = f"[#{idx + 1} {word!r}]"

        # Check 1: required fields populated
        for field in REQUIRED_FIELDS:
            if field not in entry:
                errors.append(f"{label} field={field!r}: missing")
            elif _is_empty(entry[field]):
                errors.append(f"{label} field={field!r}: empty or null")

        # Check 2: ship values
        ship = entry.get('ship', '')
        if not isinstance(ship, str) or ship.upper() not in VALID_SHIP:
            errors.append(f"{label} field='ship': must be YES/NO/MAYBE, got {ship!r}")

        # Check 3: severity range 1-5 (integer)
        severity = entry.get('severity')
        if not isinstance(severity, int) or not (1 <= severity <= 5):
            errors.append(f"{label} field='severity': must be integer 1-5, got {severity!r}")

        # Check 4: region values
        region = entry.get('region', '')
        if not isinstance(region, str) or region.upper() not in VALID_REGIONS:
            errors.append(f"{label} field='region': must be one of {sorted(VALID_REGIONS)}, got {region!r}")

        # Check 5: length matches len(word.replace(' ', ''))
        length = entry.get('length')
        if isinstance(word, str):
            expected_length = len(word.replace(' ', ''))
            if length != expected_length:
                errors.append(
                    f"{label} field='length': expected {expected_length} "
                    f"(len of {word!r} without spaces), got {length!r}"
                )

        # Check 6: is_single_word matches ' ' not in word
        is_single_word = entry.get('is_single_word')
        if isinstance(word, str):
            expected_isw = ' ' not in word
            if is_single_word != expected_isw:
                errors.append(
                    f"{label} field='is_single_word': expected {expected_isw} "
                    f"for word {word!r}, got {is_single_word!r}"
                )

        # Check 7: wordle_eligible consistency
        wordle_eligible = entry.get('wordle_eligible')
        if isinstance(severity, int) and isinstance(length, int) and isinstance(is_single_word, bool):
            ship_val = ship.upper() if isinstance(ship, str) else ''
            should_be_eligible = (
                is_single_word
                and length in WORDLE_ELIGIBLE_LENGTHS
                and severity <= 3
                and ship_val == 'YES'
            )
            if wordle_eligible != should_be_eligible:
                errors.append(
                    f"{label} field='wordle_eligible': expected {should_be_eligible} "
                    f"(is_single_word={is_single_word}, length={length}, "
                    f"severity={severity}, ship={ship_val!r}), got {wordle_eligible!r}"
                )

        # Check 10: tags is a non-empty list of strings
        tags = entry.get('tags')
        if not isinstance(tags, list) or len(tags) == 0:
            errors.append(f"{label} field='tags': must be a non-empty list of strings")
        elif not all(isinstance(t, str) for t in tags):
            errors.append(f"{label} field='tags': all items must be strings")

        # Check 12: tame_ok / filthy_ok must be bools (v0.3.0)
        tame_ok = entry.get('tame_ok')
        filthy_ok = entry.get('filthy_ok')
        if not isinstance(tame_ok, bool):
            errors.append(f"{label} field='tame_ok': must be bool, got {tame_ok!r}")
        if not isinstance(filthy_ok, bool):
            errors.append(f"{label} field='filthy_ok': must be bool, got {filthy_ok!r}")

        # Check 13: tame_ok / filthy_ok consistency with severity (warn, not fail).
        # Override is allowed — see plan editorial line — but lint surfaces it for review.
        if isinstance(severity, int) and isinstance(tame_ok, bool):
            if tame_ok != default_tame_ok(severity):
                warnings.append(
                    f"{label} field='tame_ok'={tame_ok} differs from default "
                    f"({default_tame_ok(severity)} for severity {severity}) — confirm override is intentional"
                )
        if isinstance(severity, int) and isinstance(filthy_ok, bool):
            if filthy_ok != default_filthy_ok(severity):
                warnings.append(
                    f"{label} field='filthy_ok'={filthy_ok} differs from default "
                    f"({default_filthy_ok(severity)} for severity {severity}) — confirm override is intentional"
                )

        # Check 14: must be eligible for at least one mode (otherwise unreachable)
        if tame_ok is False and filthy_ok is False:
            errors.append(
                f"{label} fields='tame_ok'+'filthy_ok': both false — word is unreachable "
                f"in any tonal mode. Either delete the entry or set one to true."
            )

        # Check 15: slur blocklist (only if blocklist file present)
        if blocklist is not None and isinstance(word, str):
            tokens = {word.upper()}
            variants = entry.get('variants') or []
            if isinstance(variants, list):
                tokens.update(v.upper() for v in variants if isinstance(v, str))
            hits = tokens & blocklist
            if hits:
                errors.append(
                    f"{label} word/variants matched slur blocklist: {sorted(hits)}. "
                    f"Action: delete this entry from the lexicon. "
                    f"Slurs are not softened, re-rated, or kept under override — they are removed."
                )

        # Check 8: no duplicate words
        word_key = word.upper() if isinstance(word, str) else word
        if word_key in seen_words:
            errors.append(
                f"{label} field='word': duplicate of entry #{seen_words[word_key] + 1}"
            )
        else:
            seen_words[word_key] = idx

        # Check 9: no duplicate IDs
        entry_id = entry.get('id')
        if entry_id in seen_ids:
            errors.append(
                f"{label} field='id': duplicate of entry #{seen_ids[entry_id] + 1}"
            )
        else:
            seen_ids[entry_id] = idx

    return errors, warnings


def main():
    errors, warnings = lint(JSON_PATH)
    if warnings:
        print(f"WARNINGS: {len(warnings)} item(s)")
        for w in warnings:
            print(f"  {w}")
    if errors:
        print(f"ERRORS: {len(errors)} issue(s) found in {JSON_PATH}")
        for e in errors:
            print(f"  {e}")
        sys.exit(1)
    else:
        data = json.load(open(JSON_PATH, encoding='utf-8'))
        count = len(data.get('words', []))
        print(f"OK: {count} words, 0 errors")
        sys.exit(0)


if __name__ == '__main__':
    main()
