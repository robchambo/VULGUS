# Plan: Expand the VULGUS dictionary into a reusable, game-agnostic lexicon

## Context

**Goal.** Grow the dictionary so VULGUS can build 90+ high-quality puzzles, **and** so the same dataset can be reused as a drop-in lexicon for other word games. **Wordle-style (5-letter, single word) is the explicit second-game target**; Connections-style, crossword, and trivia/etymology quizzes are likely follow-ons. The earlier Claude proposal (draft ~150 new entries, "categorise existing words", add a smarter generator) is partly right and partly built on a false premise.

**Confirmed decisions from the user:**

- Schema-first, then content.
- Canonical format switches from xlsx → JSON, with xlsx regenerated for review.
- Target size: **~500 words** (roughly 3.4× the current 147) — enough for 150+ VULGUS puzzles and genuine portability to a second game.
- Wordle is the nearest second-game target; other formats (crossword, trivia, anagram) should remain addressable by the schema but aren't explicitly designed for yet.

### What the prior suggestion got wrong

The prior suggestion claimed *"the Category column in the xlsx is completely empty"*. That is incorrect. The `Dictionary` sheet already has 19 columns populated for all 147 words: Severity (1-5), Region, Era, Semantic Type, **Category 1–4**, Etymology Note, Puzzle Difficulty, Ship status, two reviewers, source, date approved. So "Task 2: categorise existing words" is ~90% already done; the remaining gap is finer sub-themes (Category 4 is only filled 14 times).

### What the numbers actually say

| Metric | Value | Implication |
|---|---|---|
| Words in dictionary | 147 | Most-shipped: 145 YES, 2 MAYBE |
| Distinct categories in use | 23 | But wildly uneven (see below) |
| Puzzles built | 50 | 802 tile slots filled |
| Avg uses per word | **5.42** | Reuse is high but legal — validator blocks duplicate *groups* not words |
| Words used 5+ times | 95 / 148 | ~64% of the stock is "hot" |
| Top reused | SNOLLYGOSTER (13×), NIMROD/BOLLOCKS/NUMPTY/PILLOCK/DIPSTICK/KNACKERS/BERK/VARLET/MOUNTEBANK/BOGUS (10× each) | These words risk becoming predictable |

**Category skew (top categories by word count):**

- American Swears — 87 words (59% of dictionary)
- Exclamations — 36, Words for Nonsense — 32, Words for Idiot — 30
- Soft Swears — 26, Workplace-Safe — 25, Archaic — 22
- British Swears — 17, Animals — 13, Anatomy — 9, Foods — 8
- Intensifiers — 7, **Shakespearean — 6, Victorian — 5, Eponymous — 5, Scottish/Irish — 5, Australian — 4, Sci-Fi — 4, Scatological — 2, Rhyming Slang — 1**

**Regional skew:** US=93, GLOBAL=14, UK=20, ARCHAIC=8, FICTIONAL=4, AU=3, IE=3, SCO=2.

**Real bottleneck:** not total word count — it's (a) distinct *thematically coherent* 4-word groups, (b) regional/era diversity, (c) thinness of several flagged categories. The 87-word "American Swears" is a giant undifferentiated bucket that the generator is already *informally* splitting into sub-themes (Yiddish, Military, Southern, Midwest, Frontier, Internet, Gen-Z) without those sub-themes existing in the xlsx.

## Recommended approach

A **theme-first, portable-schema** expansion — done in four sequenced passes. Ordered so each pass delivers shippable value before the next starts.

### Pass 1 — Schema upgrade (make the dictionary game-agnostic, with Wordle as the concrete second-game target)

Add columns/sheets to the xlsx so the dataset is reusable outside VULGUS. Don't just bolt on more rows — fix the shape first so pass 2 onward is additive.

**New columns on the `Dictionary` sheet:**

| Column | Type | Why it matters (★ = required for Wordle) |
|---|---|---|
| `Length` | int (char count, **sans spaces**) | ★ Wordle filter (=5), crossword fit, hangman |
| `Is Single Word` | bool | ★ Wordle needs single-word; VULGUS happily uses `HOLY MACKEREL`, `CHARLIE FOXTROT`. This flag cleanly splits the two pools |
| `Part of Speech` | enum (noun, verb, adj, interj, phrase) | Crossword clues, grammar-aware games |
| `Definition` | short prose (<= 120 chars) | ★ Wordle post-solve reveal; crossword clue source (distinct from etymology) |
| `First Attested` | year (e.g. 1567) — nullable | Historical-era puzzles; replaces fuzzy Era band |
| `Tags` | free-text, comma-separated | Replaces over-flowing Category 1-4 with flat multi-tag |
| `Register` | enum (formal, informal, taboo, vulgar, euphemism, archaic) | Tone-based games; also Ofcom-rating sanity check |
| `Family` | parent word ID for variants/derivatives | Morphology games; also lets "wanker" point to "wank" |
| `Wordle Eligible` | bool — derived | Convenience flag: `Is Single Word = true` AND `Length in {4,5,6,7}` AND `Severity ≤ 3` AND `Ship = YES` |
| `License` | enum (public-domain, fair-use attribution, proprietary) | Licensing clarity for portable reuse |

Deliberately **omit IPA / phonetic transcription** for now — Wordle doesn't need it, and a half-populated IPA column is worse than none. Leave it as a v0.3 consideration once a rhyme-based game is in scope.

**Category 1-4 → Tags migration.** Collapse the four `Category N` columns into one `Tags` column (comma-separated). Re-index the 14 Category-4 entries and any finer themes the generator is already using (`yiddish-origin`, `mil-acronym`, `southern-us`, `midwest-us`, `frontier-us`, `gen-z`, `internet-era`, `cockney`, etc.) as proper tags. This single change unlocks much better querying.

**New top-level sheets:**

- `Themes` — puzzle-friendly thematic groupings (distinct from semantic Categories). Each theme has: id, display name, intended difficulty, region filter, tag filter, example groups. A theme is a *recipe* the generator can use.
- `Groups` — every approved 4-word group, with a theme id, a stable group id, and which puzzles it's been used in. Becomes the canonical "unit of reuse" rather than rebuilding from dart files.
- `Sources` — each source (OED, Etymonline, Green's, Ofcom, Wiktionary, LDNOOBW, Surge-AI) with a URL, access date, and any licensing caveat.

### Pass 2 — Source-of-truth refactor

Right now the xlsx is canonical and the dart puzzle files are generated from it. That's fine until two people edit it, or you want to diff it in git. Switch to:

- **Canonical:** `dictionary/vulgus_lexicon.json` (single file, one word per object, schema-versioned).
- **Generated for review:** `dictionary/VULGUS_Dictionary_v0.2.xlsx` — built from the JSON by a script so anyone can open it in Excel to browse/review.
- **Generated for other games:** `dictionary/vulgus_lexicon.csv` — flat CSV export of the JSON for tools that can't read JSON.
- xlsx stops being committed as the source; it becomes a build artefact in `.gitignore` with a "last built: <hash>" sheet.

Benefit: diffable in git, scriptable from any language, zero Excel dependency for CI, and other games can consume the JSON directly.

### Pass 3 — Theme-first content expansion (not word-first)

Instead of "draft 150 more entries" in isolation, work backwards from the **puzzles** we want to ship:

1. Enumerate the next 40 puzzles as **titles + 4 theme shapes each** — just the shape, no tiles. Example: *Puzzle 053 "Cockney Corner" = [Rhyming slang Y] [Costermonger shouts B] [East-End ruderies R] [Prison argot K]*.
2. For each shape, count current stock in the matching tags. If a shape has <6 candidate words, it's a shopping list item.
3. Draft **targeted** new dictionary entries (word + tags + etymology + source) to fill *only* those shortfalls. This usually comes out to ~60-120 new words, not 150 blind.
4. Parallel: **split "American Swears"** into the informal sub-themes the generator is already using, so the 87-word bucket becomes queryable by Yiddish/Military/Southern/Midwest/Frontier/Internet/Gen-Z/Eponymous-US.
5. Also expand the genuinely thin themes flagged in the README (Shakespearean, Australian) and adjacent ones (Cockney rhyming slang, Medieval, Edwardian, Nautical, Workplace/HR-safe, Children's substitutes, Sports-broadcast, Food-based, Scatological, Animal insults, Theatrical/Shakespeare adjacent like "plague take thee").

Target after pass 3: **~500 words, ~40 theme tags, all regions ≥25 words, Severity 1-3 distribution roughly 55/30/15, and ≥120 words flagged `Wordle Eligible` (single word, 4-7 letters, severity ≤3)**.

**Wordle-eligible sub-goal.** Of the current 147 words, a quick check suggests roughly 40-60 are already 4-7 single-word forms that fit Wordle norms (e.g. DAMN, CRAP, HECK, DARN, DANG, WALLY, BERK, PRAT, NUMPTY, DORK, DWEEB, TWIT, KNAVE, VARLET…). We should **deliberately over-produce Wordle-eligible words** in pass 3 — roughly half of the new drafts should aim to be 4-7 letters, single-word, severity ≤3 — so the second game has enough surface area at launch without needing a second expansion round.

### Pass 4 — Tooling upgrades

Upgrade `scripts/` with:

- `scripts/lint_lexicon.py` — schema validation: all required columns populated, Ship∈{YES/NO/MAYBE}, Severity∈{1..5}, every tag declared in `Themes.tags`, every word's region declared in `Regions`, etc. Hook into CI later.
- `scripts/suggest_groups.py` — given a theme id, enumerate candidate 4-word combinations from matching-tagged words, deduplicate against existing `Groups`, and rank by: (a) minimum per-word reuse count (prefer under-used words), (b) tag tightness (all 4 share ≥2 tags), (c) region/era coherence. Outputs candidates to a CSV for human review; does not auto-commit.
- `scripts/generate_puzzles.py` — unchanged interface, but adds a `--reuse-budget N` flag that warns when a tile has been used ≥N times already, and uses the `Groups` sheet rather than re-scanning dart files.
- `scripts/export_etymologies.py` — unchanged.

### What about a "smarter puzzle generator"?

Deliberately *not* building a fully-automated puzzle generator. The product's pillar is "playful, not mean" and etymology-first; a human reviewer has to approve every group. `suggest_groups.py` above is the right ceiling: machine proposes, human selects.

## Critical files

- `dictionary/VULGUS_Dictionary_v0.1.xlsx` — current source of truth; will be superseded by JSON in pass 2 but kept readable.
- `dictionary/category_etymologies.csv` — generated from dart files; keep as-is.
- `scripts/generate_puzzles.py` — puzzle compiler; add reuse-budget flag in pass 4.
- `scripts/export_etymologies.py` — keep as-is.
- `flutter_app/lib/game/data/vulgus_*.dart` — 50 puzzle files; format unchanged by this plan.
- `flutter_app/lib/game/data/puzzle_library.dart` — auto-generated index; untouched.
- `README.md` — update after pass 1/2 to reference the new schema and reusable lexicon.
- `docs/VULGUS_GDD_v0.1.docx` — should get a dictionary-schema appendix after pass 1.

**New files introduced:**

- `dictionary/vulgus_lexicon.json` (canonical, pass 2)
- `dictionary/vulgus_lexicon.csv` (export, pass 2)
- `scripts/build_xlsx.py` (build xlsx from json, pass 2)
- `scripts/lint_lexicon.py` (pass 4)
- `scripts/suggest_groups.py` (pass 4)

## Verification

- **Pass 1.** Open the upgraded xlsx. Spot-check 20 random words — each has non-empty Length, Part of Speech, Definition, Pronunciation, First Attested, Tags, Register, License. Run `python3 scripts/generate_puzzles.py` and confirm it still produces byte-identical dart output (schema change must be additive, not breaking).
- **Pass 2.** `diff <(jq -S . dictionary/vulgus_lexicon.json) <(python3 scripts/build_xlsx.py --dump-json)` should match. Regenerate xlsx from json and confirm Dictionary sheet equals the previous xlsx data on overlapping columns. Run puzzle generator against the new pipeline — still byte-identical output.
- **Pass 3.** After expansion: `scripts/lint_lexicon.py` passes. Regional counts all ≥15. American-Swears bucket split — verify the old generator's informal sub-theme comments now map 1:1 to real tags. Build puzzles 051–090 with the updated generator; average per-word reuse across 090 puzzles should drop below 4.5.
- **Pass 4.** Run `scripts/suggest_groups.py --theme shakespearean` and confirm it proposes ≥10 distinct candidate 4-groups that don't collide with `Groups`. Run `scripts/generate_puzzles.py --reuse-budget 6` and confirm it flags currently over-used words (SNOLLYGOSTER, NIMROD, BERK, etc.) if re-introduced.
- **Cross-game smoke test (Wordle).** Consume `vulgus_lexicon.json` from a throwaway Python script:
  - Filter `Wordle Eligible = true` AND `Length = 5`.
  - Confirm the result is a clean list of ≥40 single-word 5-letter entries with definitions ready to display post-solve.
  - Pick 5 at random; confirm each one would be defensible as a daily Wordle answer (real word, not slur-adjacent, has a short definition).

## Deferred / open

- **Licensing & open-sourcing.** Haven't been asked yet; matters once the lexicon is reusable outside this repo because some sources (OED full entries) can't be lifted verbatim. Flag as a decision before the schema is finalised in pass 1 (needs the `License` column to be populated from the start).
- **Third-game selection.** Wordle is confirmed as the second game. If crossword is the probable third, a `Clue` column (as distinct from `Definition`) becomes valuable — parkable until there's a specific crossword use case.
- **IPA / rhyme indexing.** Deferred until a rhyme- or pun-based game is in scope. Schema leaves room to add later without migration.
