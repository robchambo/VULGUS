import 'models/guess.dart';
import 'models/puzzle.dart';

class GameState {
  final Puzzle puzzle;
  final List<String> activeTiles;
  final Set<String> selected;
  final String? lastTapped;
  final List<String> solved;
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

  bool get isLost => mistakes >= 4;
  bool get isWon => solved.length == puzzle.categories.length && !isLost;
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
