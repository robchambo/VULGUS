import 'puzzle_category.dart';

class Puzzle {
  final String id;
  final List<PuzzleCategory> categories;

  const Puzzle({required this.id, required this.categories});

  List<String> allWords() => [
        for (final c in categories) ...c.tiles,
      ];
}
