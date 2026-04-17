import 'models/guess.dart';
import 'models/puzzle.dart';

const _shapes = ['\u25A0', '\u25CF', '\u25B2', '\u25C6'];
const _fallback = '\u25A1';

Map<String, String> _shapeMap(Puzzle puzzle) => {
      for (var i = 0; i < puzzle.categories.length; i++)
        puzzle.categories[i].id: _shapes[i % _shapes.length],
    };

String buildShareGrid(List<Guess> guesses, Puzzle puzzle) {
  final shapes = _shapeMap(puzzle);
  return guesses
      .map((g) => g.categoryIds.map((id) => shapes[id] ?? _fallback).join(' '))
      .join('\n');
}

String buildShareText({
  required String puzzleId,
  required List<Guess> guesses,
  required int solved,
  required int mistakes,
  required Puzzle puzzle,
}) {
  final mistakeWord = mistakes == 1 ? 'mistake' : 'mistakes';
  final lines = [
    'VULGUS $puzzleId',
    if (guesses.isNotEmpty) buildShareGrid(guesses, puzzle),
    '$solved/4 \u2014 $mistakes $mistakeWord',
  ];
  return lines.join('\n');
}
