import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/game/mini_puzzle_controller.dart';
import 'package:vulgus/game/mini_puzzle_data.dart';

void main() {
  test('starts with all tiles unsolved, 4 lives, 0 selected', () {
    final container = ProviderContainer();
    final s = container.read(miniPuzzleProvider);
    expect(s.tiles.length, 8);
    expect(s.lives, 4);
    expect(s.selected, isEmpty);
    expect(s.solvedCategories, isEmpty);
  });

  test('selecting up to 4 tiles works; 5th tap is ignored', () {
    final container = ProviderContainer();
    final c = container.read(miniPuzzleProvider.notifier);
    final tiles = container.read(miniPuzzleProvider).tiles;
    for (var i = 0; i < 5; i++) {
      c.toggle(tiles[i].word);
    }
    expect(container.read(miniPuzzleProvider).selected.length, 4);
  });

  test('submitting a correct group solves the category and clears selection', () {
    final container = ProviderContainer();
    final c = container.read(miniPuzzleProvider.notifier);
    for (final w in miniCategories[0].tiles) {
      c.toggle(w);
    }
    c.submit();
    final s = container.read(miniPuzzleProvider);
    expect(s.solvedCategories, contains(miniCategories[0].id));
    expect(s.selected, isEmpty);
    expect(s.lives, 4);
  });

  test('submitting an incorrect group costs a life and clears selection', () {
    final container = ProviderContainer();
    final c = container.read(miniPuzzleProvider.notifier);
    final tiles = container.read(miniPuzzleProvider).tiles;
    final mixed = [
      tiles.firstWhere((t) => t.categoryId == miniCategories[0].id).word,
      tiles.firstWhere((t) => t.categoryId == miniCategories[1].id).word,
      tiles
          .where((t) => t.categoryId == miniCategories[0].id)
          .elementAt(1)
          .word,
      tiles
          .where((t) => t.categoryId == miniCategories[1].id)
          .elementAt(1)
          .word,
    ];
    for (final w in mixed) {
      c.toggle(w);
    }
    c.submit();
    final s = container.read(miniPuzzleProvider);
    expect(s.lives, 3);
    expect(s.selected, isEmpty);
    expect(s.solvedCategories, isEmpty);
    expect(s.lastWasCorrect, false);
  });

  test('isComplete true when both categories solved', () {
    final container = ProviderContainer();
    final c = container.read(miniPuzzleProvider.notifier);
    for (final cat in miniCategories) {
      for (final w in cat.tiles) {
        c.toggle(w);
      }
      c.submit();
    }
    expect(container.read(miniPuzzleProvider).isComplete, isTrue);
  });
}
