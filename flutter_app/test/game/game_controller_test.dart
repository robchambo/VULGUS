import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/game/data/vulgus_001.dart';
import 'package:vulgus/game/daily_puzzle_service.dart';
import 'package:vulgus/game/game_controller.dart';

// Pin the daily puzzle to vulgus001 so tests are date-independent.
ProviderContainer fresh() => ProviderContainer(
      overrides: [dailyPuzzleProvider.overrideWithValue(vulgus001)],
    );

void main() {
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

  test('4 mistakes ends the game (lose) and reveals remaining categories', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final cats = vulgus001.categories;
    for (var i = 0; i < 4; i++) {
      for (final w in [cats[0].tiles[i % 4], cats[1].tiles[i % 4], cats[2].tiles[i % 4], cats[3].tiles[i % 4]]) {
        ctrl.tap(w);
      }
      ctrl.submit();
    }
    final s = c.read(gameControllerProvider);
    expect(s.mistakes, 4);
    expect(s.isOver, isTrue);
    expect(s.isWon, isFalse);
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

  test('shuffle keeps active tile count and members', () {
    final c = fresh();
    final ctrl = c.read(gameControllerProvider.notifier);
    final before = [...c.read(gameControllerProvider).activeTiles];
    ctrl.shuffle();
    final after = c.read(gameControllerProvider).activeTiles;
    expect(after.length, before.length);
    expect({...after}, equals({...before}));
  });
}
