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
