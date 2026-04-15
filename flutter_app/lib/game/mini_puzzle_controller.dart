import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mini_puzzle_data.dart';
import 'models/puzzle_tile.dart';

class MiniPuzzleState {
  final List<PuzzleTile> tiles;
  final Set<String> selected;
  final Set<String> solvedCategories;
  final int lives;
  final bool? lastWasCorrect;

  const MiniPuzzleState({
    required this.tiles,
    this.selected = const {},
    this.solvedCategories = const {},
    this.lives = 4,
    this.lastWasCorrect,
  });

  MiniPuzzleState copyWith({
    Set<String>? selected,
    Set<String>? solvedCategories,
    int? lives,
    bool? lastWasCorrect,
  }) =>
      MiniPuzzleState(
        tiles: tiles,
        selected: selected ?? this.selected,
        solvedCategories: solvedCategories ?? this.solvedCategories,
        lives: lives ?? this.lives,
        lastWasCorrect: lastWasCorrect,
      );

  bool get isComplete => solvedCategories.length == miniCategories.length;
  bool get isFailed => lives <= 0;
}

class MiniPuzzleController extends StateNotifier<MiniPuzzleState> {
  MiniPuzzleController() : super(MiniPuzzleState(tiles: miniTiles()));

  void toggle(String word) {
    final next = {...state.selected};
    if (next.contains(word)) {
      next.remove(word);
    } else if (next.length < 4) {
      next.add(word);
    }
    state = state.copyWith(selected: next);
  }

  void submit() {
    if (state.selected.length != 4) return;
    final picked = state.tiles.where((t) => state.selected.contains(t.word));
    final ids = picked.map((t) => t.categoryId).toSet();
    if (ids.length == 1) {
      state = state.copyWith(
        solvedCategories: {...state.solvedCategories, ids.first},
        selected: {},
        lastWasCorrect: true,
      );
    } else {
      state = state.copyWith(
        lives: state.lives - 1,
        selected: {},
        lastWasCorrect: false,
      );
    }
  }
}

final miniPuzzleProvider =
    StateNotifierProvider<MiniPuzzleController, MiniPuzzleState>(
  (ref) => MiniPuzzleController(),
);
