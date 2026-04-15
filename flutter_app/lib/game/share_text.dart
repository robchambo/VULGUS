import 'models/guess.dart';

const _shapes = <String, String>{
  'idiot': '\u25A0',
  'soft': '\u25CF',
  'british': '\u25B2',
  'nonsense': '\u25C6',
};

const _fallback = '\u25A1';

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
    '$solved/4 \u2014 $mistakes $mistakeWord',
  ];
  return lines.join('\n');
}
