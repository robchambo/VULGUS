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
        clearLastTapped: selected.isEmpty,
        lastTapped: selected.isEmpty ? null : selected.last,
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
      final newGuesses = [...state.guesses, Guess(categoryIds: catIds, correct: true)];
      state = state.copyWith(
        activeTiles: remaining,
        selected: const {},
        clearLastTapped: true,
        solved: [...state.solved, catId],
        guesses: newGuesses,
        wasLastOneAway: false,
      );
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

    if (newMistakes >= 4) {
      // auto-reveal remaining categories
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
