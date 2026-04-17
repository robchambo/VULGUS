import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/models/guess.dart';
import 'package:vulgus/game/models/puzzle.dart';
import 'package:vulgus/game/models/puzzle_category.dart';
import 'package:vulgus/game/share_text.dart';

// Minimal puzzle matching the original 001 category IDs so shapes stay
// consistent with the expected output (index 0=■, 1=●, 2=▲, 3=◆).
final _testPuzzle = Puzzle(
  id: 'TEST-001',
  categories: const [
    PuzzleCategory(id: 'idiot', label: 'A', etymology: '', tiles: ['A', 'B', 'C', 'D']),
    PuzzleCategory(id: 'soft', label: 'B', etymology: '', tiles: ['E', 'F', 'G', 'H']),
    PuzzleCategory(id: 'british', label: 'C', etymology: '', tiles: ['I', 'J', 'K', 'L']),
    PuzzleCategory(id: 'nonsense', label: 'D', etymology: '', tiles: ['M', 'N', 'O', 'P']),
  ],
);

void main() {
  test('maps category ids to Bauhaus shapes', () {
    final grid = buildShareGrid([
      const Guess(categoryIds: ['idiot', 'idiot', 'idiot', 'idiot'], correct: true),
      const Guess(categoryIds: ['soft', 'british', 'nonsense', 'idiot'], correct: false),
    ], _testPuzzle);
    expect(grid, '■ ■ ■ ■\n● ▲ ◆ ■');
  });

  test('unknown id falls back to hollow square', () {
    final grid = buildShareGrid([
      const Guess(categoryIds: ['mystery', 'idiot', 'idiot', 'idiot'], correct: false),
    ], _testPuzzle);
    expect(grid, '□ ■ ■ ■');
  });

  test('empty guess list produces empty string', () {
    expect(buildShareGrid(const [], _testPuzzle), '');
  });

  test('buildShareText includes puzzle id, grid, and score line', () {
    final text = buildShareText(
      puzzleId: 'VULGUS-001',
      guesses: [
        const Guess(categoryIds: ['idiot', 'idiot', 'idiot', 'idiot'], correct: true),
      ],
      solved: 1,
      mistakes: 0,
      puzzle: _testPuzzle,
    );
    expect(text, 'VULGUS VULGUS-001\n■ ■ ■ ■\n1/4 — 0 mistakes');
  });

  test('mistake pluralisation uses singular for 1', () {
    final text = buildShareText(
      puzzleId: 'VULGUS-001',
      guesses: [const Guess(categoryIds: ['idiot', 'idiot', 'idiot', 'soft'], correct: false)],
      solved: 0,
      mistakes: 1,
      puzzle: _testPuzzle,
    );
    expect(text, endsWith('0/4 — 1 mistake'));
  });
}
