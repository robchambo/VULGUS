# VULGUS Game Port Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Port the VULGUS game (16 tiles → 4 categories of 4, 4 lives, etymology reveal, Bauhaus share grid) from the HTML prototype (`prototype/index.html`) to the existing Flutter app at `flutter_app/`. Replace the `HomePlaceholder` with a full game experience surrounded by a persistent Bauhaus app bar + bottom nav.

**Style authority:** `C:\Users\robth\Downloads\stitch_bauhaus_word_connections\staatliche_form\DESIGN.md` (Modernist Grid — no rounded corners, tonal layering, no-line rule, signature tile grid with 2px black gutters). Visual layout references: Stitch mockups for top bar + bottom nav. **Game mechanics:** identical to `prototype/index.html` — do not invent new rules.

**Architecture:**
- **HomeShell** = stateful wrapper with bottom nav + IndexedStack. Four tabs: Play (GameScreen), Stats, Archive, Rules. Replaces `HomePlaceholder` at `/home`.
- **GameScreen** composes: `VulgusAppBar` · `PuzzleHero` (title + lives) · `SolvedBanners` · `DailyTileGrid` · `DailyEtymologyStrip` · `ActionBar` (Shuffle/Deselect/Submit), plus `BauhausBackdrop` decorative shapes and `EndModal` overlay on finish.
- **GameController** (Riverpod `StateNotifier`) owns all game logic. Pure-Dart-testable. No UI imports.
- **Mini puzzle (onboarding) stays untouched** — renamed to `MiniTileGrid` / `MiniEtymologyStrip` so the full-game widgets can take the plain names.

**Tech Stack:** unchanged from onboarding plan — Flutter, flutter_riverpod, go_router, shared_preferences, google_fonts. Adds nothing new.

**Out of scope (separate plans):**
- Multi-puzzle archive (date → puzzle mapping, local puzzle storage)
- Full Stats content (win rate, streaks — needs persistence design)
- Full Archive content (needs archive feature)
- Mild Mode toggle
- Settings
- Hint system
- Sound effects / haptics
- Backend puzzle delivery

---

## File Structure

```
flutter_app/lib/
├── game/
│   ├── models/
│   │   ├── puzzle.dart                       ← NEW: Puzzle (id, categories)
│   │   ├── puzzle_category.dart              ← EXTEND: add difficulty enum + bg/fg colour tokens
│   │   └── puzzle_tile.dart                  ← EXTEND: add selected/locked fields (optional;
│   │                                             prefer state in controller rather than model)
│   ├── data/
│   │   ├── vulgus_001.dart                   ← NEW: puzzle data lifted from prototype
│   │   └── etymologies.dart                  ← NEW: 14-entry word → {meta, note} map
│   ├── game_state.dart                       ← NEW: immutable GameState + Guess record
│   ├── game_controller.dart                  ← NEW: StateNotifier with full game logic
│   ├── share_text.dart                       ← NEW: pure fn buildShareText(GameState)
│   ├── mini_puzzle_data.dart                 ← UNCHANGED (used by onboarding demo only)
│   ├── mini_puzzle_controller.dart           ← UNCHANGED
│   └── widgets/
│       ├── tile_grid.dart                    ← RENAMED to mini_tile_grid.dart
│       │                                         (class TileGrid → MiniTileGrid)
│       ├── etymology_strip.dart              ← RENAMED to mini_etymology_strip.dart
│       │                                         (class EtymologyStrip → MiniEtymologyStrip)
│       ├── share_grid.dart                   ← RENAMED to mini_share_grid.dart
│       │                                         (class ShareGrid → MiniShareGrid)
│       ├── daily_tile_grid.dart              ← NEW: real 16-tile grid, shake on wrong
│       ├── daily_etymology_strip.dart        ← NEW: last-tapped etymology + rise-in
│       ├── solved_banners.dart               ← NEW: list of locked category banners
│       ├── action_bar.dart                   ← NEW: Shuffle · Deselect · Submit row
│       ├── puzzle_hero.dart                  ← NEW: "VULGUS / 001" asymmetric header
│       ├── lives_indicator.dart              ← NEW: 4 squares, filled/hollow
│       ├── vulgus_app_bar.dart               ← NEW: top bar (grid + wordmark + help)
│       ├── vulgus_bottom_nav.dart            ← NEW: 4-tab bottom nav
│       ├── bauhaus_backdrop.dart             ← NEW: 3 decorative shapes, low opacity
│       └── end_modal.dart                    ← NEW: win/lose overlay with share button
├── home/
│   ├── home_placeholder.dart                 ← REPLACED by home_shell.dart
│   ├── home_shell.dart                       ← NEW: app bar + body tab + bottom nav
│   └── game_screen.dart                      ← NEW: the Play tab body
├── stats/
│   └── stats_placeholder.dart                ← NEW: minimal "Coming soon" content
├── archive/
│   └── archive_placeholder.dart              ← NEW: minimal "Coming soon" content
├── rules/
│   └── rules_screen.dart                     ← NEW: how-to-play content
└── core/
    └── router.dart                           ← UPDATE: /home → HomeShell (not HomePlaceholder)

flutter_app/test/
├── game/
│   ├── share_text_test.dart                  ← 4 tests (happy/loss/empty/symbols)
│   ├── game_controller_test.dart             ← 10 tests (selection cap, submit correct,
│   │                                             submit incorrect, mistakes=4, one-away,
│   │                                             shuffle preserves locked, all-solved win, etc.)
│   └── widgets/
│       ├── daily_tile_grid_test.dart         ← renders 16 tiles, tap selects, shake on wrong
│       ├── solved_banners_test.dart          ← renders banner per solved category
│       └── end_modal_test.dart               ← renders on game over, share copies text
└── home/
    └── home_shell_test.dart                  ← renders Play tab by default, bottom nav switches tabs
```

**Decomposition rationale:** One widget per file, each with a single responsibility. Game logic is pure Dart in `game_controller.dart` + `share_text.dart` so it's unit-testable without widgets. The mini-puzzle stays isolated — renamed (not deleted) so onboarding keeps working.

---

## Bauhaus Design Reference (from DESIGN.md + prototype)

**Colour tokens** (all already in `AppColors` from onboarding Task 3, except `surfaceDim` which is added here):

| Token | Hex | Role |
|---|---|---|
| `primary` | `#B7102A` | Red category (Hard), brand accent |
| `primaryContainer` | `#DB313F` | Red hover |
| `secondary` | `#785A00` | Gold for labels |
| `secondaryContainer` | `#FFD167` | Gold category (Easy) |
| `onSecondaryContainer` | `#765900` | Text on gold |
| `tertiary` | `#006482` | Blue category (Medium), bottom-nav active |
| `tertiaryContainer` | `#007EA4` | Blue hover |
| `onSurface` | `#1B1B1B` | Black category (Trickiest), borders, text |
| `surface` | `#F9F9F9` | Background |
| `surfaceContainerLowest` | `#FFFFFF` | Lifted surfaces |
| `surfaceContainerLow` | `#F3F3F3` | Content blocks |
| `surfaceContainer` | `#EEEEEE` | — |
| `surfaceContainerHigh` | `#E8E8E8` | Hover state |
| `surfaceContainerHighest` | `#E2E2E2` | **Tile base** |
| `surfaceDim` | `#DADADA` | **NEW** — backdrop for lifted cards |
| `outline` | `#8F6F6E` | Text secondary |
| `outlineVariant` | `#E4BEBC` | Ghost borders @ 20% opacity |
| `error` | `#BA1A1A` | Error |

**Category → colour mapping** (from prototype):

| Difficulty | Code | bg token | fg token |
|---|---|---|---|
| Easy | Y | `secondaryContainer` | `onSecondaryContainer` |
| Medium | B | `tertiary` | `onTertiary` |
| Hard | R | `primary` | `onPrimary` |
| Trickiest | K | `onSurface` | `surface` |

**Signature tile grid:** 4-column GridView, tiles are `surfaceContainerHighest` base, 2px gaps with the parent showing black (`onSurface`) beneath — "stained-glass" effect. Selected tile flips to `inverseSurface` (`#303030`) with white text. Solved tiles disappear (moved into `SolvedBanners` above the grid).

**Category banners** appear above the grid, top-to-bottom in solve order: full-width, 2px black border, category bg colour, label in Space Grotesk black uppercase + words joined by ` · ` + difficulty label right-aligned.

**Etymology strip:** 2px black border, `surfaceContainerLowest` bg, min-height 96. Empty state: `"Tap a word to see where it comes from."` centred in small uppercase tracked label. Filled: headline word (Space Grotesk black uppercase), meta (right-aligned small label), body note. Rise-in animation (translateY 4px → 0, 120ms) on change.

**Lives indicator:** 4 squares, 16x16, spaced 4px. Filled (`onSurface`) = life remaining, hollow (2px `onSurface` border) = mistake used.

**Action bar:** 3-column grid, 8px gap. Shuffle + Deselect are outlined (`surface` bg, 2px `onSurface` border, black text). Submit is filled black (`onSurface` bg, `surface` text). All disabled state: opacity 30%. Active tap: 2px translate (no elevation).

**Top app bar:** fixed height 80, 2px bottom border. Left: `grid_view` icon button. Centre: `VULGUS` wordmark (Space Grotesk black, 30px, primary colour). Right: `help_outline` icon button.

**Bottom nav:** fixed height 64, 2px top border, 4 tabs. Active tab: `tertiary` bg, `onTertiary` text + icon. Inactive: `onSurface` text + icon, `surfaceContainerHigh` on hover.

**Bauhaus backdrop:** 3 fixed decorative shapes outside the interactive layer, all `-z-10` (Flutter: bottom of the Stack), low opacity:
1. Rotated primary square, top-left, 112x112, `opacity: 0.05`, rotated 45°
2. Secondary outlined square, bottom-right, 224x224, `opacity: 0.20`, 4px border
3. Tertiary circle, right-mid, 80x80, `opacity: 0.10`

---

## Puzzle data (VULGUS-001, verbatim from prototype)

```dart
// 4 categories, 4 words each
[
  (id: 'idiot',    label: 'Words for Idiot',       difficulty: Difficulty.easy,      words: ['NIMROD', 'DOOFUS', 'MUPPET', 'WALLY']),
  (id: 'soft',     label: 'Soft Swears (G-rated)', difficulty: Difficulty.medium,    words: ['SUGAR', 'FUDGE', 'SHOOT', 'CRIKEY']),
  (id: 'british',  label: 'British Swears',        difficulty: Difficulty.hard,      words: ['BOLLOCKS', 'ARSE', 'BUM', 'BLIMEY']),
  (id: 'nonsense', label: 'Words for Nonsense',    difficulty: Difficulty.trickiest, words: ['TOSH', 'CODSWALLOP', 'POPPYCOCK', 'BALDERDASH']),
]
```

Etymology dictionary (16 entries, keyed by UPPERCASE word) — lifted verbatim from prototype `ETYM`. Full content in Task 4 below.

---

## Task Index

1. Rename mini widgets to free up plain names
2. Puzzle + Guess + Difficulty models
3. VULGUS-001 puzzle data
4. Etymology data (16 entries)
5. `share_text.dart` — pure fn, TDD (4 tests)
6. `GameState` + `GameController` — TDD (10 tests)
7. Theme: add `surfaceDim` token
8. `VulgusAppBar` + `VulgusBottomNav` widgets
9. `LivesIndicator` + `PuzzleHero` widgets
10. `SolvedBanners` widget
11. `DailyTileGrid` widget (with shake animation) + TDD
12. `DailyEtymologyStrip` widget (with rise-in)
13. `ActionBar` widget (Shuffle / Deselect / Submit)
14. `BauhausBackdrop` widget
15. `EndModal` widget + share via Clipboard
16. `GameScreen` composition
17. Stats / Archive / Rules placeholder screens
18. `HomeShell` — wraps app bar, IndexedStack, bottom nav
19. Router update: `/home` → `HomeShell`
20. Full-suite verification + manual smoke test

---

## Task 1: Rename mini widgets

**Why:** The onboarding demo uses `TileGrid`, `EtymologyStrip`, `ShareGrid`. The full game needs those names. Rename the mini versions to free up the plain names.

**Files:**
- Move: `lib/game/widgets/tile_grid.dart` → `lib/game/widgets/mini_tile_grid.dart`; rename class `TileGrid` → `MiniTileGrid`
- Move: `lib/game/widgets/etymology_strip.dart` → `lib/game/widgets/mini_etymology_strip.dart`; rename `EtymologyStrip` → `MiniEtymologyStrip`
- Move: `lib/game/widgets/share_grid.dart` → `lib/game/widgets/mini_share_grid.dart`; rename `ShareGrid` → `MiniShareGrid`
- Update: `lib/onboarding/screens/demo_puzzle_screen.dart` — import + class usage
- Update: `lib/onboarding/screens/share_grid_screen.dart` — import + class usage
- Update: `test/game/widgets/tile_grid_test.dart` → `test/game/widgets/mini_tile_grid_test.dart` — import + class usage

- [ ] **Step 1: `git mv` the three widget files**

```bash
cd flutter_app
git mv lib/game/widgets/tile_grid.dart lib/game/widgets/mini_tile_grid.dart
git mv lib/game/widgets/etymology_strip.dart lib/game/widgets/mini_etymology_strip.dart
git mv lib/game/widgets/share_grid.dart lib/game/widgets/mini_share_grid.dart
git mv test/game/widgets/tile_grid_test.dart test/game/widgets/mini_tile_grid_test.dart
```

- [ ] **Step 2: Rename classes inside each file**

In each moved file, rename the public class:
- `class TileGrid extends ConsumerWidget` → `class MiniTileGrid extends ConsumerWidget`
- `class EtymologyStrip extends ConsumerWidget` → `class MiniEtymologyStrip extends ConsumerWidget`
- `class ShareGrid extends ConsumerWidget` → `class MiniShareGrid extends ConsumerWidget`

- [ ] **Step 3: Update onboarding screen imports + usages**

In `lib/onboarding/screens/demo_puzzle_screen.dart`:
- `import '../../game/widgets/tile_grid.dart'` → `import '../../game/widgets/mini_tile_grid.dart'`
- `import '../../game/widgets/etymology_strip.dart'` → `import '../../game/widgets/mini_etymology_strip.dart'`
- All `TileGrid()` → `MiniTileGrid()`
- All `EtymologyStrip()` → `MiniEtymologyStrip()`

In `lib/onboarding/screens/share_grid_screen.dart`:
- `import '../../game/widgets/share_grid.dart'` → `import '../../game/widgets/mini_share_grid.dart'`
- `const ShareGrid()` → `const MiniShareGrid()`

- [ ] **Step 4: Update test file**

In `test/game/widgets/mini_tile_grid_test.dart`:
- `import 'package:vulgus/game/widgets/tile_grid.dart'` → `import 'package:vulgus/game/widgets/mini_tile_grid.dart'`
- `home: const Scaffold(body: TileGrid())` → `home: const Scaffold(body: MiniTileGrid())`

- [ ] **Step 5: Verify — analyze + test**

```bash
flutter analyze
flutter test
```
Expected: no issues, 28/28 pass (unchanged count).

- [ ] **Step 6: Commit**

```bash
git add -A
git commit -m "refactor(game): prefix onboarding mini widgets to free up plain names"
```

---

## Task 2: Puzzle + Guess + Difficulty models

**Files:**
- Create: `lib/game/models/difficulty.dart`
- Create: `lib/game/models/puzzle.dart`
- Create: `lib/game/models/guess.dart`
- Modify: `lib/game/models/puzzle_category.dart` — replace `Color color` with `Difficulty difficulty`, derive colours via the Difficulty enum's `bg`/`fg` getters

- [ ] **Step 1: Create `lib/game/models/difficulty.dart`**

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

enum Difficulty {
  easy,       // Y
  medium,     // B
  hard,       // R
  trickiest,  // K
  ;

  String get label => switch (this) {
        Difficulty.easy => 'Easy',
        Difficulty.medium => 'Medium',
        Difficulty.hard => 'Hard',
        Difficulty.trickiest => 'Trickiest',
      };

  Color get bg => switch (this) {
        Difficulty.easy => AppColors.secondaryContainer,
        Difficulty.medium => AppColors.tertiary,
        Difficulty.hard => AppColors.primary,
        Difficulty.trickiest => AppColors.onSurface,
      };

  Color get fg => switch (this) {
        Difficulty.easy => AppColors.onSecondaryContainer,
        Difficulty.medium => AppColors.onTertiary,
        Difficulty.hard => AppColors.onPrimary,
        Difficulty.trickiest => AppColors.surface,
      };
}
```

- [ ] **Step 2: Modify `lib/game/models/puzzle_category.dart`**

Current file (from onboarding mini puzzle) uses `Color color`. Extend it so it works for both mini and full:

```dart
import 'package:flutter/material.dart';
import 'difficulty.dart';

class PuzzleCategory {
  final String id;
  final String label;
  final String etymology;
  final Color color;
  final Difficulty? difficulty;
  final List<String> tiles;

  const PuzzleCategory({
    required this.id,
    required this.label,
    required this.etymology,
    required this.color,
    required this.tiles,
    this.difficulty,
  });
}
```

- [ ] **Step 3: Create `lib/game/models/puzzle.dart`**

```dart
import 'puzzle_category.dart';

class Puzzle {
  final String id;            // e.g. "VULGUS-001"
  final List<PuzzleCategory> categories;

  const Puzzle({required this.id, required this.categories});

  List<String> allWords() => [
        for (final c in categories) ...c.tiles,
      ];
}
```

- [ ] **Step 4: Create `lib/game/models/guess.dart`**

```dart
/// A single submission — the category IDs of the 4 chosen tiles.
class Guess {
  final List<String> categoryIds;
  final bool correct;
  const Guess({required this.categoryIds, required this.correct});
}
```

- [ ] **Step 5: Verify**

```bash
flutter analyze
flutter test
```
Expected: no issues, 28/28 pass. (Mini puzzle data still builds because `difficulty` is optional on `PuzzleCategory`.)

- [ ] **Step 6: Commit**

```bash
git add lib/game/models/
git commit -m "feat(game): Puzzle, Guess, Difficulty models"
```

---

## Task 3: VULGUS-001 puzzle data

**Files:**
- Create: `lib/game/data/vulgus_001.dart`

- [ ] **Step 1: Implement**

```dart
import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

final vulgus001 = Puzzle(
  id: 'VULGUS-001',
  categories: const [
    PuzzleCategory(
      id: 'idiot',
      label: 'Words for Idiot',
      etymology: '',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['NIMROD', 'DOOFUS', 'MUPPET', 'WALLY'],
    ),
    PuzzleCategory(
      id: 'soft',
      label: 'Soft Swears (G-rated)',
      etymology: '',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SUGAR', 'FUDGE', 'SHOOT', 'CRIKEY'],
    ),
    PuzzleCategory(
      id: 'british',
      label: 'British Swears',
      etymology: '',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'ARSE', 'BUM', 'BLIMEY'],
    ),
    PuzzleCategory(
      id: 'nonsense',
      label: 'Words for Nonsense',
      etymology: '',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['TOSH', 'CODSWALLOP', 'POPPYCOCK', 'BALDERDASH'],
    ),
  ],
);
```

`etymology` is blank at the category level because the real etymology lives per-word in `etymologies.dart` (Task 4). The field is kept so the existing `PuzzleCategory` shape is reused.

- [ ] **Step 2: Analyze + commit**

```bash
flutter analyze
git add lib/game/data/vulgus_001.dart
git commit -m "feat(game): VULGUS-001 puzzle data (4 categories × 4 words)"
```

---

## Task 4: Etymology data (16 entries)

**Files:**
- Create: `lib/game/data/etymologies.dart`

- [ ] **Step 1: Implement**

```dart
class Etymology {
  final String meta;   // e.g. "UK · 19th C"
  final String note;
  const Etymology({required this.meta, required this.note});
}

const etymologies = <String, Etymology>{
  'NIMROD':     Etymology(meta: 'eponymous · Bugs Bunny',   note: 'Biblical mighty hunter — inverted to mean "fool" after Bugs Bunny sarcastically called Elmer Fudd a Nimrod.'),
  'DOOFUS':     Etymology(meta: 'US · 1960s',               note: 'US college slang of uncertain origin; a harmless, lovable fool.'),
  'MUPPET':     Etymology(meta: 'UK · 1980s',               note: "From Jim Henson's Muppets; adopted as a gentle British insult meaning clueless person."),
  'WALLY':      Etymology(meta: 'UK · 1960s',               note: '1960s British slang for a fool; possibly from the name Walter, or a cry heard at a 1965 festival.'),
  'SUGAR':      Etymology(meta: 'global · 20th C',          note: 'Polite stand-in for a stronger s-word; popularised as a minced oath in the early 1900s.'),
  'FUDGE':      Etymology(meta: 'global · 17th C',          note: 'Originally "to fake or bungle"; euphemism for the f-word by the 19th century.'),
  'SHOOT':      Etymology(meta: 'US · 19th C',              note: 'American minced oath for a stronger s-word; in use since the mid-1800s.'),
  'CRIKEY':     Etymology(meta: 'UK/AU · 19th C',           note: 'Minced oath for "Christ"; popular in Britain and Australia since the 1830s.'),
  'BOLLOCKS':   Etymology(meta: 'UK · Old English',         note: 'From Old English beallucas (testicles); by the 1860s meant "nonsense". Sex Pistols made it famous in 1977.'),
  'ARSE':       Etymology(meta: 'UK · Old English',         note: 'From Old English ærs, cognate with German Arsch. Standard British form of American "ass".'),
  'BUM':        Etymology(meta: 'UK · 14th C',              note: "Middle English, probably onomatopoeic. A mild British anatomical word, common in children's speech."),
  'BLIMEY':     Etymology(meta: 'UK · 19th C',              note: '"God blind me!" — a minced oath used as an exclamation of surprise.'),
  'TOSH':       Etymology(meta: 'UK · 19th C',              note: 'British slang for rubbish; origin disputed. Often paired with "utter".'),
  'CODSWALLOP': Etymology(meta: 'UK · 20th C',              note: "Possibly from Hiram Codd's 1872 bottle plus \"wallop\" (beer) — worthless fizzy water, hence nonsense."),
  'POPPYCOCK':  Etymology(meta: 'US · 19th C',              note: 'From Dutch pappekak — "soft dung". Sounds polite; originally was anything but.'),
  'BALDERDASH': Etymology(meta: '16th C',                   note: 'Originally a 16th-century frothy drink mix; by the 1670s it meant senseless talk.'),
};
```

- [ ] **Step 2: Commit**

```bash
flutter analyze
git add lib/game/data/etymologies.dart
git commit -m "feat(game): etymology data (16 entries for VULGUS-001)"
```

---

## Task 5: `share_text.dart` — pure fn, TDD

**Files:**
- Create: `lib/game/share_text.dart`
- Test: `test/game/share_text_test.dart`

The share grid uses one line per guess. Each line = 4 shapes separated by spaces, one per tile in the guess. Shape depends on category id:

| Category id | Shape | Codepoint |
|---|---|---|
| `idiot` | Square | `■` `\u25A0` |
| `soft` | Circle | `●` `\u25CF` |
| `british` | Triangle | `▲` `\u25B2` |
| `nonsense` | Diamond | `◆` `\u25C6` |
| any other / unknown | Hollow square | `□` `\u25A1` |

Full share text header:
```
VULGUS VULGUS-001
<one line per guess>
<solvedCount>/4 — <mistakes> mistake(s)
```

- [ ] **Step 1: Test** — Create `test/game/share_text_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/models/guess.dart';
import 'package:vulgus/game/share_text.dart';

void main() {
  test('maps category ids to Bauhaus shapes', () {
    final grid = buildShareGrid([
      const Guess(categoryIds: ['idiot', 'idiot', 'idiot', 'idiot'], correct: true),
      const Guess(categoryIds: ['soft', 'british', 'nonsense', 'idiot'], correct: false),
    ]);
    expect(grid, '■ ■ ■ ■\n● ▲ ◆ ■');
  });

  test('unknown id falls back to hollow square', () {
    final grid = buildShareGrid([
      const Guess(categoryIds: ['mystery', 'idiot', 'idiot', 'idiot'], correct: false),
    ]);
    expect(grid, '□ ■ ■ ■');
  });

  test('empty guess list produces empty string', () {
    expect(buildShareGrid(const []), '');
  });

  test('buildShareText includes puzzle id, grid, and score line', () {
    final text = buildShareText(
      puzzleId: 'VULGUS-001',
      guesses: [
        const Guess(categoryIds: ['idiot', 'idiot', 'idiot', 'idiot'], correct: true),
      ],
      solved: 1,
      mistakes: 0,
    );
    expect(text, 'VULGUS VULGUS-001\n■ ■ ■ ■\n1/4 — 0 mistakes');
  });

  test('mistake pluralisation uses singular for 1', () {
    final text = buildShareText(
      puzzleId: 'VULGUS-001',
      guesses: [const Guess(categoryIds: ['idiot', 'idiot', 'idiot', 'soft'], correct: false)],
      solved: 0,
      mistakes: 1,
    );
    expect(text, endsWith('0/4 — 1 mistake'));
  });
}
```

- [ ] **Step 2: Run — FAIL**

```bash
flutter test test/game/share_text_test.dart
```

- [ ] **Step 3: Implement `lib/game/share_text.dart`**

```dart
import 'models/guess.dart';

const _shapes = <String, String>{
  'idiot': '\u25A0',      // ■
  'soft': '\u25CF',       // ●
  'british': '\u25B2',    // ▲
  'nonsense': '\u25C6',   // ◆
};

const _fallback = '\u25A1';  // □

String buildShareGrid(List<Guess> guesses) => guesses
    .map((g) => g.categoryIds.map((id) => _shapes[id] ?? _fallback).join(' '))
    .join('\n');

String buildShareText({
  required String puzzleId,
  required List<Guess> guesses,
  required int solved,
  required int mistakes,
}) {
  final mistakeWord = mistakes == 1 ? 'mistake' : 'mistakes';
  final lines = [
    'VULGUS $puzzleId',
    if (guesses.isNotEmpty) buildShareGrid(guesses),
    '$solved/4 — $mistakes $mistakeWord',
  ];
  return lines.join('\n');
}
```

- [ ] **Step 4: Run — PASS (5/5)**

- [ ] **Step 5: Commit**

```bash
git add lib/game/share_text.dart test/game/share_text_test.dart
git commit -m "feat(game): share text + grid builder"
```

---

## Task 6: GameState + GameController — TDD

**Files:**
- Create: `lib/game/game_state.dart`
- Create: `lib/game/game_controller.dart`
- Test: `test/game/game_controller_test.dart`

Ported from the prototype's `onSubmit` / `onTileClick` / `btnShuffle` logic. Full-puzzle version of the existing mini controller.

- [ ] **Step 1: Test** — Create `test/game/game_controller_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/game/data/vulgus_001.dart';
import 'package:vulgus/game/game_controller.dart';
import 'package:vulgus/game/game_state.dart';

void main() {
  ProviderContainer fresh() => ProviderContainer();

  test('starts with 16 tiles, 0 mistakes, 0 solved, no last-tapped', () {
    final c = fresh();
    final s = c.read(gameControllerProvider);
    expect(s.activeTiles.length, 16);
    expect(s.mistakes, 0);
    expect(s.solved, isEmpty);
    expect(s.lastTapped, isNull);
    expect(s.isOver, isFalse);
    expect(s.isWon, isFalse);
  });

  test('tap selects and stores lastTapped', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final first = c.read(gameControllerProvider).activeTiles.first;
    ctrl.tap(first);
    final s = c.read(gameControllerProvider);
    expect(s.selected, {first});
    expect(s.lastTapped, first);
  });

  test('second tap on same tile deselects', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final first = c.read(gameControllerProvider).activeTiles.first;
    ctrl.tap(first);
    ctrl.tap(first);
    expect(c.read(gameControllerProvider).selected, isEmpty);
  });

  test('cannot select more than 4', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final tiles = c.read(gameControllerProvider).activeTiles;
    for (var i = 0; i < 5; i++) {
      ctrl.tap(tiles[i]);
    }
    expect(c.read(gameControllerProvider).selected.length, 4);
  });

  test('submit correct solves category, clears selection, no mistake', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    for (final w in vulgus001.categories[0].tiles) {
      ctrl.tap(w);
    }
    ctrl.submit();
    final s = c.read(gameControllerProvider);
    expect(s.solved, contains(vulgus001.categories[0].id));
    expect(s.selected, isEmpty);
    expect(s.mistakes, 0);
    expect(s.activeTiles.length, 12);
    expect(s.guesses.length, 1);
    expect(s.guesses.first.correct, isTrue);
  });

  test('submit wrong costs a life and records incorrect guess', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final a = vulgus001.categories[0].tiles[0];
    final b = vulgus001.categories[1].tiles[0];
    final aa = vulgus001.categories[0].tiles[1];
    final bb = vulgus001.categories[1].tiles[1];
    for (final w in [a, b, aa, bb]) {
      ctrl.tap(w);
    }
    ctrl.submit();
    final s = c.read(gameControllerProvider);
    expect(s.mistakes, 1);
    expect(s.selected, isEmpty);
    expect(s.solved, isEmpty);
    expect(s.guesses.single.correct, isFalse);
  });

  test('one-away detection (3 of one category + 1 of another)', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final a1 = vulgus001.categories[0].tiles[0];
    final a2 = vulgus001.categories[0].tiles[1];
    final a3 = vulgus001.categories[0].tiles[2];
    final b1 = vulgus001.categories[1].tiles[0];
    for (final w in [a1, a2, a3, b1]) {
      ctrl.tap(w);
    }
    ctrl.submit();
    final s = c.read(gameControllerProvider);
    expect(s.wasLastOneAway, isTrue);
  });

  test('4 mistakes ends the game (lose)', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final cats = vulgus001.categories;
    for (var i = 0; i < 4; i++) {
      // always pick 4 mixed-category tiles
      for (final w in [cats[0].tiles[i % 4], cats[1].tiles[i % 4], cats[2].tiles[i % 4], cats[3].tiles[i % 4]]) {
        ctrl.tap(w);
      }
      ctrl.submit();
      // deselect may be required if state isn't cleared — submit clears selection on both paths, so OK
    }
    final s = c.read(gameControllerProvider);
    expect(s.mistakes, 4);
    expect(s.isOver, isTrue);
    expect(s.isWon, isFalse);
    // all 4 categories auto-revealed on lose
    expect(s.solved.length, 4);
  });

  test('solving all 4 categories ends the game (win)', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    for (final cat in vulgus001.categories) {
      for (final w in cat.tiles) {
        ctrl.tap(w);
      }
      ctrl.submit();
    }
    final s = c.read(gameControllerProvider);
    expect(s.isOver, isTrue);
    expect(s.isWon, isTrue);
    expect(s.solved.length, 4);
  });

  test('deselectAll clears selection and lastTapped', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    ctrl.tap(vulgus001.categories[0].tiles[0]);
    ctrl.tap(vulgus001.categories[0].tiles[1]);
    ctrl.deselectAll();
    final s = c.read(gameControllerProvider);
    expect(s.selected, isEmpty);
    expect(s.lastTapped, isNull);
  });

  test('shuffle keeps active tile count but changes order (deterministic seed test-friendly)', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final before = [...c.read(gameControllerProvider).activeTiles];
    ctrl.shuffle();
    final after = c.read(gameControllerProvider).activeTiles;
    expect(after.length, before.length);
    expect({...after}, equals({...before}));
  });
}
```

- [ ] **Step 2: Run — FAIL**

- [ ] **Step 3: Implement `lib/game/game_state.dart`**

```dart
import 'models/guess.dart';
import 'models/puzzle.dart';

class GameState {
  final Puzzle puzzle;
  final List<String> activeTiles;    // in display order; words are uppercase
  final Set<String> selected;
  final String? lastTapped;
  final List<String> solved;          // category ids, in solve order
  final int mistakes;
  final List<Guess> guesses;
  final bool wasLastOneAway;

  const GameState({
    required this.puzzle,
    required this.activeTiles,
    this.selected = const {},
    this.lastTapped,
    this.solved = const [],
    this.mistakes = 0,
    this.guesses = const [],
    this.wasLastOneAway = false,
  });

  bool get isWon => solved.length == puzzle.categories.length;
  bool get isLost => mistakes >= 4;
  bool get isOver => isWon || isLost;

  GameState copyWith({
    List<String>? activeTiles,
    Set<String>? selected,
    String? lastTapped,
    bool clearLastTapped = false,
    List<String>? solved,
    int? mistakes,
    List<Guess>? guesses,
    bool? wasLastOneAway,
  }) =>
      GameState(
        puzzle: puzzle,
        activeTiles: activeTiles ?? this.activeTiles,
        selected: selected ?? this.selected,
        lastTapped: clearLastTapped ? null : (lastTapped ?? this.lastTapped),
        solved: solved ?? this.solved,
        mistakes: mistakes ?? this.mistakes,
        guesses: guesses ?? this.guesses,
        wasLastOneAway: wasLastOneAway ?? this.wasLastOneAway,
      );
}
```

- [ ] **Step 4: Implement `lib/game/game_controller.dart`**

```dart
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/vulgus_001.dart';
import 'game_state.dart';
import 'models/guess.dart';
import 'models/puzzle.dart';

class GameController extends StateNotifier<GameState> {
  GameController({Puzzle? puzzle, Random? rng})
      : _rng = rng ?? Random(),
        super(_initialState(puzzle ?? vulgus001, rng ?? Random()));

  final Random _rng;

  static GameState _initialState(Puzzle puzzle, Random rng) {
    final all = [for (final c in puzzle.categories) ...c.tiles]..shuffle(rng);
    return GameState(puzzle: puzzle, activeTiles: all);
  }

  String _categoryOf(String word) =>
      state.puzzle.categories.firstWhere((c) => c.tiles.contains(word)).id;

  void tap(String word) {
    if (state.isOver) return;
    if (!state.activeTiles.contains(word)) return;
    final selected = {...state.selected};
    if (selected.contains(word)) {
      selected.remove(word);
      state = state.copyWith(
        selected: selected,
        lastTapped: selected.isEmpty ? null : selected.last,
        clearLastTapped: selected.isEmpty,
      );
      return;
    }
    if (selected.length >= 4) return;
    selected.add(word);
    state = state.copyWith(selected: selected, lastTapped: word);
  }

  void deselectAll() {
    state = state.copyWith(selected: const {}, clearLastTapped: true);
  }

  void shuffle() {
    final active = [...state.activeTiles]..shuffle(_rng);
    state = state.copyWith(activeTiles: active);
  }

  void submit() {
    if (state.selected.length != 4 || state.isOver) return;
    final picked = state.selected.toList();
    final catIds = picked.map(_categoryOf).toList();
    final unique = catIds.toSet();
    if (unique.length == 1) {
      final catId = unique.first;
      final cat = state.puzzle.categories.firstWhere((c) => c.id == catId);
      final remaining = [
        for (final w in state.activeTiles)
          if (!cat.tiles.contains(w)) w,
      ];
      final newSolved = [...state.solved, catId];
      final won = newSolved.length == state.puzzle.categories.length;
      final newGuesses = [...state.guesses, Guess(categoryIds: catIds, correct: true)];
      state = state.copyWith(
        activeTiles: remaining,
        selected: const {},
        clearLastTapped: true,
        solved: newSolved,
        guesses: newGuesses,
        wasLastOneAway: false,
      );
      if (won) {
        // mark all solved (already) and end game — handled via isOver
      }
      return;
    }

    // wrong
    final counts = <String, int>{};
    for (final id in catIds) {
      counts[id] = (counts[id] ?? 0) + 1;
    }
    final oneAway = counts.values.contains(3);
    final newMistakes = state.mistakes + 1;
    final newGuesses = [...state.guesses, Guess(categoryIds: catIds, correct: false)];
    final lost = newMistakes >= 4;
    if (lost) {
      // auto-reveal: mark remaining categories as solved; clear active tiles
      final remainingCats = [
        for (final c in state.puzzle.categories)
          if (!state.solved.contains(c.id)) c.id,
      ];
      state = state.copyWith(
        activeTiles: const [],
        selected: const {},
        clearLastTapped: true,
        mistakes: newMistakes,
        solved: [...state.solved, ...remainingCats],
        guesses: newGuesses,
        wasLastOneAway: oneAway,
      );
      return;
    }
    state = state.copyWith(
      selected: const {},
      clearLastTapped: true,
      mistakes: newMistakes,
      guesses: newGuesses,
      wasLastOneAway: oneAway,
    );
  }
}

final gameControllerProvider =
    StateNotifierProvider<GameController, GameState>(
  (ref) => GameController(),
);
```

**Note:** The `selected.last` access in `tap` relies on `Set<String>` preserving insertion order — Dart's default `LinkedHashSet` does. The `.last` on a `Set` returns the last-inserted element.

- [ ] **Step 5: Run — PASS (10/10)**

```bash
flutter test test/game/game_controller_test.dart
```

If the shuffle test flakes (order could coincidentally equal original), it's unlikely with 16 items but if it does, pass a seeded `Random(42)` through a test-only constructor and assert different order.

- [ ] **Step 6: Commit**

```bash
git add lib/game/game_state.dart lib/game/game_controller.dart test/game/game_controller_test.dart
git commit -m "feat(game): GameState + GameController with full puzzle logic"
```

---

## Task 7: Theme — add `surfaceDim` token

**Files:**
- Modify: `lib/theme/app_colors.dart`

- [ ] **Step 1: Add constant**

In `lib/theme/app_colors.dart`, add (keep alphabetical/thematic with existing tokens):

```dart
  static const surfaceDim = Color(0xFFDADADA);
```

- [ ] **Step 2: Verify + commit**

```bash
flutter analyze
flutter test test/theme/
git add lib/theme/app_colors.dart
git commit -m "feat(theme): add surfaceDim token per DESIGN.md"
```

---

## Task 8: `VulgusAppBar` + `VulgusBottomNav`

**Files:**
- Create: `lib/game/widgets/vulgus_app_bar.dart`
- Create: `lib/game/widgets/vulgus_bottom_nav.dart`

- [ ] **Step 1: `vulgus_app_bar.dart`**

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class VulgusAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenu;
  final VoidCallback? onHelp;
  const VulgusAppBar({super.key, this.onMenu, this.onHelp});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      child: Row(
        children: [
          _IconButton(icon: Icons.grid_view, onPressed: onMenu, semanticLabel: 'Menu'),
          const Spacer(),
          Text(
            'VULGUS',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
          ),
          const Spacer(),
          _IconButton(icon: Icons.help_outline, onPressed: onHelp, semanticLabel: 'How to play'),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String semanticLabel;
  const _IconButton({required this.icon, required this.onPressed, required this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: AppColors.onSurface, size: 28, semanticLabel: semanticLabel),
      ),
    );
  }
}
```

- [ ] **Step 2: `vulgus_bottom_nav.dart`**

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class VulgusBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const VulgusBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _items = <({IconData icon, String label})>[
    (icon: Icons.play_arrow, label: 'PLAY'),
    (icon: Icons.leaderboard, label: 'STATS'),
    (icon: Icons.history, label: 'ARCHIVE'),
    (icon: Icons.menu_book, label: 'RULES'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < _items.length; i++)
            Expanded(
              child: _Tab(
                icon: _items[i].icon,
                label: _items[i].label,
                active: i == currentIndex,
                onTap: () => onTap(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Tab({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = active ? AppColors.tertiary : AppColors.surface;
    final fg = active ? AppColors.onTertiary : AppColors.onSurface;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: bg,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: fg, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: fg,
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
flutter analyze
git add lib/game/widgets/vulgus_app_bar.dart lib/game/widgets/vulgus_bottom_nav.dart
git commit -m "feat(game): VulgusAppBar + VulgusBottomNav"
```

---

## Task 9: `LivesIndicator` + `PuzzleHero`

**Files:**
- Create: `lib/game/widgets/lives_indicator.dart`
- Create: `lib/game/widgets/puzzle_hero.dart`

- [ ] **Step 1: `lives_indicator.dart`**

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class LivesIndicator extends StatelessWidget {
  final int mistakes;   // 0..4
  const LivesIndicator({super.key, required this.mistakes});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 4; i++)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: i < 4 - mistakes
                ? Container(width: 16, height: 16, color: AppColors.onSurface)
                : Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.onSurface, width: 2),
                    ),
                  ),
          ),
      ],
    );
  }
}
```

- [ ] **Step 2: `puzzle_hero.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';
import 'lives_indicator.dart';

class PuzzleHero extends ConsumerWidget {
  const PuzzleHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    final parts = s.puzzle.id.split('-');
    final top = parts.first;
    final num = parts.length > 1 ? parts.last : '';
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DAILY PUZZLE',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.secondary,
                        fontSize: 11,
                        letterSpacing: 3,
                      ),
                ),
                Text(
                  '$top\n$num',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 56,
                        height: 0.9,
                        letterSpacing: -3,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('MISTAKES',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 10, letterSpacing: 2)),
              const SizedBox(height: 6),
              LivesIndicator(mistakes: s.mistakes),
            ],
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
flutter analyze
git add lib/game/widgets/lives_indicator.dart lib/game/widgets/puzzle_hero.dart
git commit -m "feat(game): PuzzleHero + LivesIndicator"
```

---

## Task 10: `SolvedBanners` widget + test

**Files:**
- Create: `lib/game/widgets/solved_banners.dart`
- Test: `test/game/widgets/solved_banners_test.dart`

- [ ] **Step 1: Test** — Create `test/game/widgets/solved_banners_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/game_controller.dart';
import 'package:vulgus/game/widgets/solved_banners.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('shows one banner per solved category with label + words', (tester) async {
    final container = ProviderContainer();
    // Solve the first category via the controller
    final ctrl = container.read(gameControllerProvider.notifier);
    final cat = container.read(gameControllerProvider).puzzle.categories.first;
    for (final w in cat.tiles) {
      ctrl.tap(w);
    }
    ctrl.submit();

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: SolvedBanners()),
      ),
    ));
    expect(find.textContaining(cat.label.toUpperCase()), findsOneWidget);
    expect(find.textContaining(cat.tiles.first), findsOneWidget);
  });
}
```

- [ ] **Step 2: Implement**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';
import '../models/difficulty.dart';

class SolvedBanners extends ConsumerWidget {
  const SolvedBanners({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    if (s.solved.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (final id in s.solved)
          _Banner(categoryId: id),
      ],
    );
  }
}

class _Banner extends ConsumerWidget {
  final String categoryId;
  const _Banner({required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzle = ref.watch(gameControllerProvider).puzzle;
    final cat = puzzle.categories.firstWhere((c) => c.id == categoryId);
    final difficulty = cat.difficulty ?? Difficulty.easy;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: difficulty.bg,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  cat.label.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: difficulty.fg,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                ),
              ),
              Text(
                difficulty.label.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: difficulty.fg,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            cat.tiles.join(' · '),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: difficulty.fg,
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Test → PASS, commit**

```bash
flutter test test/game/widgets/solved_banners_test.dart
git add lib/game/widgets/solved_banners.dart test/game/widgets/solved_banners_test.dart
git commit -m "feat(game): SolvedBanners with difficulty-coloured banner per solved category"
```

---

## Task 11: `DailyTileGrid` — tile grid with shake animation

**Files:**
- Create: `lib/game/widgets/daily_tile_grid.dart`
- Test: `test/game/widgets/daily_tile_grid_test.dart`

The grid adapts rows based on active tile count (4 cols × ceil(count / 4) rows). Tiles use the same selected/solved mapping as the prototype.

Shake animation: when `wasLastOneAway` is true OR any incorrect submission just happened, shake the grid once. Trigger via `AnimationController` + listening to state changes.

- [ ] **Step 1: Test** — Create `test/game/widgets/daily_tile_grid_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/game_controller.dart';
import 'package:vulgus/game/widgets/daily_tile_grid.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders 16 active tile buttons initially', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: DailyTileGrid()),
      ),
    ));
    expect(find.byType(InkWell), findsNWidgets(16));
  });

  testWidgets('tapping a tile selects it in the controller', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: DailyTileGrid()),
      ),
    ));
    final first = container.read(gameControllerProvider).activeTiles.first;
    await tester.tap(find.text(first));
    await tester.pump();
    expect(container.read(gameControllerProvider).selected, contains(first));
  });

  testWidgets('after solving one category, only 12 tiles are shown', (tester) async {
    final container = ProviderContainer();
    final ctrl = container.read(gameControllerProvider.notifier);
    final cat = container.read(gameControllerProvider).puzzle.categories.first;
    for (final w in cat.tiles) {
      ctrl.tap(w);
    }
    ctrl.submit();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: DailyTileGrid()),
      ),
    ));
    expect(find.byType(InkWell), findsNWidgets(12));
  });
}
```

- [ ] **Step 2: Implement**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';

class DailyTileGrid extends ConsumerStatefulWidget {
  const DailyTileGrid({super.key});
  @override
  ConsumerState<DailyTileGrid> createState() => _DailyTileGridState();
}

class _DailyTileGridState extends ConsumerState<DailyTileGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shake;
  int _lastGuessCount = 0;

  @override
  void initState() {
    super.initState();
    _shake = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
  }

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(gameControllerProvider);
    final ctrl = ref.read(gameControllerProvider.notifier);

    // trigger shake on new wrong guess
    if (s.guesses.length > _lastGuessCount) {
      final lastWrong = s.guesses.last.correct == false;
      _lastGuessCount = s.guesses.length;
      if (lastWrong && !_shake.isAnimating) {
        _shake.forward(from: 0);
      }
    }

    return AnimatedBuilder(
      animation: _shake,
      builder: (context, child) {
        final t = _shake.value;
        final dx = t == 0 ? 0.0 : (t < 0.2 ? -6 : (t < 0.4 ? 6 : (t < 0.6 ? -4 : (t < 0.8 ? 4 : 0))));
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: Container(
        color: AppColors.onSurface,
        padding: const EdgeInsets.all(1),
        child: GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1,
          children: [
            for (final word in s.activeTiles)
              _Tile(
                word: word,
                selected: s.selected.contains(word),
                onTap: () => ctrl.tap(word),
              ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String word;
  final bool selected;
  final VoidCallback onTap;
  const _Tile({required this.word, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.inverseSurfaceBlack : AppColors.surfaceContainerHighest;
    final fg = selected ? AppColors.onPrimary : AppColors.onSurface;
    return Material(
      color: bg,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                word,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

**Note:** `AppColors.inverseSurfaceBlack` doesn't exist yet. Add it in Task 7's theme file — use the token `Color(0xFF303030)` per DESIGN.md's inverse-surface. If Task 7 already completed, add it now:

```dart
static const inverseSurfaceBlack = Color(0xFF303030);
```

- [ ] **Step 3: Test → PASS, commit**

```bash
flutter test test/game/widgets/daily_tile_grid_test.dart
git add lib/game/widgets/daily_tile_grid.dart test/game/widgets/daily_tile_grid_test.dart lib/theme/app_colors.dart
git commit -m "feat(game): DailyTileGrid with shake on wrong guess"
```

---

## Task 12: `DailyEtymologyStrip`

**Files:**
- Create: `lib/game/widgets/daily_etymology_strip.dart`

- [ ] **Step 1: Implement**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../data/etymologies.dart';
import '../game_controller.dart';

class DailyEtymologyStrip extends ConsumerWidget {
  const DailyEtymologyStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    final word = s.lastTapped;
    return Container(
      constraints: const BoxConstraints(minHeight: 96),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: word == null
          ? Center(
              child: Text(
                'TAP A WORD TO SEE WHERE IT COMES FROM.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                      letterSpacing: 2,
                    ),
              ),
            )
          : _Filled(word: word, ety: etymologies[word]),
    );
  }
}

class _Filled extends StatelessWidget {
  final String word;
  final dynamic ety;
  const _Filled({required this.word, required this.ety});

  @override
  Widget build(BuildContext context) {
    final meta = (ety?.meta as String?) ?? '';
    final note = (ety?.note as String?) ?? '(etymology pending)';
    return TweenAnimationBuilder<double>(
      key: ValueKey(word),
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 120),
      builder: (_, t, __) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, (1 - t) * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      word,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                    ),
                  ),
                  if (meta.isNotEmpty)
                    Text(
                      meta.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 10,
                            letterSpacing: 2,
                          ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(note, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
flutter analyze
git add lib/game/widgets/daily_etymology_strip.dart
git commit -m "feat(game): DailyEtymologyStrip with rise-in on change"
```

---

## Task 13: `ActionBar` — Shuffle · Deselect · Submit

**Files:**
- Create: `lib/game/widgets/action_bar.dart`

- [ ] **Step 1: Implement**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    final ctrl = ref.read(gameControllerProvider.notifier);
    final canSubmit = s.selected.length == 4 && !s.isOver;
    final canDeselect = s.selected.isNotEmpty && !s.isOver;

    return Row(
      children: [
        Expanded(
          child: _OutlineButton(
            label: 'Shuffle',
            onPressed: s.isOver ? null : ctrl.shuffle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _OutlineButton(
            label: 'Deselect',
            onPressed: canDeselect ? ctrl.deselectAll : null,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilledButton(
            label: 'Submit',
            onPressed: canSubmit ? ctrl.submit : null,
          ),
        ),
      ],
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _OutlineButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.onSurface,
          side: const BorderSide(color: AppColors.onSurface, width: 2),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.5),
        ),
        child: Text(label.toUpperCase()),
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _FilledButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.onSurface,
          foregroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: AppColors.onSurface, width: 2),
          ),
          minimumSize: const Size.fromHeight(52),
          elevation: 0,
          textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
        ),
        child: Text(label.toUpperCase()),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
flutter analyze
git add lib/game/widgets/action_bar.dart
git commit -m "feat(game): ActionBar (Shuffle / Deselect / Submit)"
```

---

## Task 14: `BauhausBackdrop`

**Files:**
- Create: `lib/game/widgets/bauhaus_backdrop.dart`

- [ ] **Step 1: Implement**

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Three decorative shapes fixed to the screen at low opacity.
/// Lives behind the interactive layer (use as the first child in a Stack).
class BauhausBackdrop extends StatelessWidget {
  const BauhausBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Rotated primary square, top-left
          Positioned(
            top: 96,
            left: -40,
            child: Transform.rotate(
              angle: pi / 4,
              child: Container(
                width: 112, height: 112,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Outlined secondary square, bottom-right
          Positioned(
            bottom: 96,
            right: -80,
            child: Container(
              width: 224, height: 224,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.5),
                  width: 4,
                ),
              ),
            ),
          ),
          // Tertiary circle, right mid
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 40,
            right: 32,
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.tertiary.withValues(alpha: 0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
flutter analyze
git add lib/game/widgets/bauhaus_backdrop.dart
git commit -m "feat(game): BauhausBackdrop decorative shapes"
```

---

## Task 15: `EndModal` + share + test

**Files:**
- Create: `lib/game/widgets/end_modal.dart`
- Test: `test/game/widgets/end_modal_test.dart`

- [ ] **Step 1: Test** — Create `test/game/widgets/end_modal_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/game_controller.dart';
import 'package:vulgus/game/widgets/end_modal.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders win title + share grid + buttons on full solve', (tester) async {
    final container = ProviderContainer();
    final ctrl = container.read(gameControllerProvider.notifier);
    for (final cat in container.read(gameControllerProvider).puzzle.categories) {
      for (final w in cat.tiles) {
        ctrl.tap(w);
      }
      ctrl.submit();
    }
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const Scaffold(body: EndModal())),
    ));
    expect(find.textContaining('SORTED'), findsOneWidget);
    expect(find.text('COPY SHARE'), findsOneWidget);
    expect(find.text('PLAY AGAIN'), findsOneWidget);
  });

  testWidgets('copy share button writes text to clipboard', (tester) async {
    final container = ProviderContainer();
    final ctrl = container.read(gameControllerProvider.notifier);
    for (final cat in container.read(gameControllerProvider).puzzle.categories) {
      for (final w in cat.tiles) {
        ctrl.tap(w);
      }
      ctrl.submit();
    }
    String? copied;
    SystemChannels.platform.setMockMethodCallHandler((call) async {
      if (call.method == 'Clipboard.setData') {
        copied = (call.arguments as Map)['text'] as String?;
      }
      return null;
    });
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const Scaffold(body: EndModal())),
    ));
    await tester.tap(find.text('COPY SHARE'));
    await tester.pump();
    expect(copied, contains('VULGUS VULGUS-001'));
  });
}
```

- [ ] **Step 2: Implement**

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';
import '../share_text.dart';

class EndModal extends ConsumerWidget {
  const EndModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    if (!s.isOver) return const SizedBox.shrink();
    final t = Theme.of(context).textTheme;
    final share = buildShareText(
      puzzleId: s.puzzle.id,
      guesses: s.guesses,
      solved: s.solved.length.clamp(0, s.puzzle.categories.length),
      mistakes: s.mistakes,
    );
    final title = s.isWon ? 'SORTED THE SWEARY.' : 'TRY TOMORROW.';
    final body = s.isWon
        ? 'Done in ${s.guesses.length} guesses, ${s.mistakes} mistake${s.mistakes == 1 ? '' : 's'}.'
        : 'Ran out of lives after ${s.guesses.length} guesses.';

    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          border: Border.all(color: AppColors.onSurface, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RESULT',
                style: t.labelLarge?.copyWith(color: AppColors.secondary, letterSpacing: 3)),
            const SizedBox(height: 8),
            Text(title, style: t.displayMedium?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -1, height: 0.95)),
            const SizedBox(height: 16),
            Text(body, style: t.bodyMedium),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.surfaceContainerHigh,
              child: Text(
                buildShareGrid(s.guesses),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 20,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Clipboard.setData(ClipboardData(text: share)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tertiary,
                      foregroundColor: AppColors.onTertiary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: AppColors.onSurface, width: 2),
                      ),
                      minimumSize: const Size.fromHeight(48),
                      elevation: 0,
                    ),
                    child: const Text('COPY SHARE'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => ref.refresh(gameControllerProvider),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.onSurface,
                      side: const BorderSide(color: AppColors.onSurface, width: 2),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text('PLAY AGAIN'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

**Note:** `ref.refresh` on a `StateNotifierProvider` re-initialises the provider, giving a fresh `GameController` and a new shuffled puzzle — effectively "play again".

- [ ] **Step 3: Test → PASS, commit**

```bash
flutter test test/game/widgets/end_modal_test.dart
git add lib/game/widgets/end_modal.dart test/game/widgets/end_modal_test.dart
git commit -m "feat(game): EndModal with share + play again"
```

---

## Task 16: `GameScreen` composition

**Files:**
- Create: `lib/home/game_screen.dart`

- [ ] **Step 1: Implement**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game/widgets/action_bar.dart';
import '../game/widgets/bauhaus_backdrop.dart';
import '../game/widgets/daily_etymology_strip.dart';
import '../game/widgets/daily_tile_grid.dart';
import '../game/widgets/end_modal.dart';
import '../game/widgets/puzzle_hero.dart';
import '../game/widgets/solved_banners.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        const BauhausBackdrop(),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              PuzzleHero(),
              SizedBox(height: 16),
              SolvedBanners(),
              DailyTileGrid(),
              SizedBox(height: 12),
              DailyEtymologyStrip(),
              SizedBox(height: 16),
              ActionBar(),
            ],
          ),
        ),
        const EndModal(),
      ],
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
flutter analyze
git add lib/home/game_screen.dart
git commit -m "feat(game): GameScreen composition"
```

---

## Task 17: Stats / Archive / Rules placeholders

**Files:**
- Create: `lib/stats/stats_placeholder.dart`
- Create: `lib/archive/archive_placeholder.dart`
- Create: `lib/rules/rules_screen.dart`

- [ ] **Step 1: Stats placeholder**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StatsPlaceholder extends StatelessWidget {
  const StatsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return _ComingSoon(title: 'STATS', body: 'Streaks, win rate, and hardest categories land with VULGUS+.');
  }
}

class _ComingSoon extends StatelessWidget {
  final String title;
  final String body;
  const _ComingSoon({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text('COMING SOON',
              style: t.labelLarge?.copyWith(color: AppColors.secondary, letterSpacing: 3)),
          const SizedBox(height: 4),
          Text(title, style: t.displayLarge?.copyWith(fontSize: 56, height: 0.9, letterSpacing: -2)),
          const SizedBox(height: 16),
          Text(body, style: t.bodyLarge),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Archive placeholder**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ArchivePlaceholder extends StatelessWidget {
  const ArchivePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text('COMING SOON',
              style: t.labelLarge?.copyWith(color: AppColors.secondary, letterSpacing: 3)),
          const SizedBox(height: 4),
          Text('ARCHIVE', style: t.displayLarge?.copyWith(fontSize: 56, height: 0.9, letterSpacing: -2)),
          const SizedBox(height: 16),
          Text('Every past VULGUS puzzle will live here. Unlocked with VULGUS+.', style: t.bodyLarge),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Rules screen**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text('HOW TO PLAY',
              style: t.labelLarge?.copyWith(color: AppColors.secondary, letterSpacing: 3)),
          const SizedBox(height: 4),
          Text('RULES', style: t.displayLarge?.copyWith(fontSize: 64, height: 0.9, letterSpacing: -2)),
          const SizedBox(height: 24),
          _Rule('1', 'SIXTEEN WORDS.', 'Sort them into four secret categories of four.'),
          _Rule('2', 'FOUR MISTAKES.', "Submit a wrong group and you lose a life. Four strikes and today's puzzle is done."),
          _Rule('3', 'ETYMOLOGY.', 'Tap any tile to learn where the word comes from. The trick is in the history.'),
          _Rule('4', 'ONE A DAY.', 'New puzzle every morning. Share your run, keep your streak, repeat.'),
        ],
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  final String n;
  final String title;
  final String body;
  const _Rule(this.n, this.title, this.body);

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            child: Text(n,
                style: t.displayMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                )),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: t.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(body, style: t.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Commit**

```bash
flutter analyze
git add lib/stats/ lib/archive/ lib/rules/
git commit -m "feat(home): stats/archive placeholders + rules content"
```

---

## Task 18: `HomeShell` — app bar + IndexedStack + bottom nav

**Files:**
- Create: `lib/home/home_shell.dart`
- Test: `test/home/home_shell_test.dart`

- [ ] **Step 1: Test** — Create `test/home/home_shell_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/home/home_shell.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('Play tab is active by default and shows daily puzzle hero',
      (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const HomeShell()),
    ));
    expect(find.textContaining('DAILY PUZZLE'), findsOneWidget);
  });

  testWidgets('tapping Rules tab switches body', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const HomeShell()),
    ));
    await tester.tap(find.text('RULES'));
    await tester.pumpAndSettle();
    expect(find.textContaining('HOW TO PLAY'), findsOneWidget);
  });
}
```

- [ ] **Step 2: Implement**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../archive/archive_placeholder.dart';
import '../game/widgets/vulgus_app_bar.dart';
import '../game/widgets/vulgus_bottom_nav.dart';
import '../rules/rules_screen.dart';
import '../stats/stats_placeholder.dart';
import 'game_screen.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});
  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _tab = 0;

  static const _tabs = <Widget>[
    GameScreen(),
    StatsPlaceholder(),
    ArchivePlaceholder(),
    RulesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VulgusAppBar(),
      body: SafeArea(
        top: false,
        child: IndexedStack(index: _tab, children: _tabs),
      ),
      bottomNavigationBar: VulgusBottomNav(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}
```

- [ ] **Step 3: Test → PASS**

- [ ] **Step 4: Commit**

```bash
git add lib/home/home_shell.dart test/home/home_shell_test.dart
git commit -m "feat(home): HomeShell with persistent app bar + bottom nav + 4 tabs"
```

---

## Task 19: Router update — `/home` → `HomeShell`

**Files:**
- Modify: `lib/core/router.dart`
- Delete: `lib/home/home_placeholder.dart`
- Modify: `test/core/router_test.dart` — `find.byKey('home_placeholder')` no longer valid; assert on the VULGUS wordmark instead

- [ ] **Step 1: Update router**

In `lib/core/router.dart`:
- Replace `import '../home/home_placeholder.dart';` with `import '../home/home_shell.dart';`
- Replace `GoRoute(path: '/home', builder: (_, __) => const HomePlaceholder())` with `GoRoute(path: '/home', builder: (_, __) => const HomeShell())`

- [ ] **Step 2: Delete the old placeholder**

```bash
git rm flutter_app/lib/home/home_placeholder.dart
```

- [ ] **Step 3: Update router test**

In `test/core/router_test.dart`, change the "routes to /home when onboarding complete" test:
- Remove `import 'package:vulgus/core/first_launch.dart';` if unused
- Change `expect(find.byKey(const Key('home_placeholder')), findsOneWidget);` to `expect(find.text('VULGUS'), findsWidgets);` (the wordmark appears in the app bar)

- [ ] **Step 4: Run full suite**

```bash
flutter analyze
flutter test
```
Expected: no issues, all tests pass. There may be animation-timer leaks from `DailyTileGrid` during widget tests — if any test errors with "A Timer is still pending even after the widget tree was disposed", wrap the pump in `await tester.pumpAndSettle(const Duration(seconds: 1))`.

- [ ] **Step 5: Commit**

```bash
git add -A
git commit -m "feat(core): route /home to HomeShell; remove HomePlaceholder"
```

---

## Task 20: Full-suite verification + manual smoke test

- [ ] **Step 1: Verify**

```bash
cd flutter_app
flutter analyze           # no issues
flutter test              # all tests pass (target: 40+ tests after all new additions)
```

- [ ] **Step 2: Run on browser**

```bash
flutter run -d chrome
```

Walk through:
1. Fresh install → onboarding flows → after early-access screen, lands on `HomeShell`
2. Top app bar shows `VULGUS` wordmark, grid + help icons
3. Bottom nav shows 4 tabs, Play is active (blue)
4. Game board shows "VULGUS / 001", 4 mistakes squares, 16 tiles in a 4×4 grid
5. Tap a tile → it goes black with white text; etymology strip fills with that word
6. Select 4 tiles from the same category → Submit enables → tap → category banner appears above, tiles removed, mistakes unchanged
7. Select 4 wrong tiles → submit → grid shakes, one mistake square becomes hollow, tiles deselected
8. Solve all four → EndModal appears with "SORTED THE SWEARY." and share grid
9. Tap COPY SHARE → clipboard now has `VULGUS VULGUS-001\n...`
10. Tap PLAY AGAIN → new shuffled puzzle, 4 lives restored
11. Tap Rules tab → rules screen
12. Tap Stats / Archive → placeholders
13. Kill + relaunch → boots straight to HomeShell (onboarding skipped)

- [ ] **Step 3: If smoke test reveals issues, fix and commit**

Common issues to watch for:
- Scrolling behaviour: the game board on small viewports may clip — confirm `SingleChildScrollView` wraps correctly
- Shake animation glitches on rapid submits — add debounce if needed
- Etymology rise-in re-triggers on every state change not just `lastTapped` change — use `AnimatedSwitcher` keyed on `lastTapped` if problematic

- [ ] **Step 4: Push**

```bash
git push origin main
```

---

## Self-Review

**Spec coverage:**
- ✅ 16-tile 4×4 grid, 4 categories × 4 words — Tasks 3, 11
- ✅ Etymology strip, last-tapped reveal, rise-in — Tasks 4, 12
- ✅ Tap to select (max 4), deselect, shuffle — Tasks 6, 11, 13
- ✅ Submit correct → banner + lock, incorrect → shake + mistake — Tasks 6, 10, 11
- ✅ 4 lives, auto-reveal on loss — Task 6
- ✅ One-away detection — Task 6
- ✅ Share grid with 4 Bauhaus shapes — Task 5, 15
- ✅ End modal win/loss with share + play again — Task 15
- ✅ Bauhaus top bar + bottom nav — Tasks 8, 18
- ✅ Stats / Archive / Rules tabs — Task 17, 18
- ✅ Tonal layering, 0px radius, 2px black borders, category colour banners — throughout
- ✅ Decorative backdrop shapes — Task 14
- ✅ Onboarding still works and lands on the new HomeShell — Task 19
- ✅ Mini puzzle onboarding demo still works — Task 1 (rename, not delete)

**Type/name consistency:**
- `Puzzle`, `PuzzleCategory`, `PuzzleTile`, `Guess`, `Difficulty`, `Etymology`, `GameState`, `GameController`, `gameControllerProvider`
- Widgets: `DailyTileGrid` / `DailyEtymologyStrip` for full game vs `MiniTileGrid` / `MiniEtymologyStrip` / `MiniShareGrid` for onboarding
- Routes unchanged: `/home` → HomeShell (was HomePlaceholder)

**Out of scope (next plans):**
- Multiple puzzles + date routing
- Full Stats (streak logic, persistence)
- Full Archive (list, filters, lock per-puzzle behind Plus)
- Mild Mode
- Settings
- Sound / haptics
- Hint system
