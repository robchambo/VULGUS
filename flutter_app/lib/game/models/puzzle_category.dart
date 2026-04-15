import 'package:flutter/material.dart';

class PuzzleCategory {
  final String id;
  final String label;
  final String etymology;
  final Color color;
  final List<String> tiles;

  const PuzzleCategory({
    required this.id,
    required this.label,
    required this.etymology,
    required this.color,
    required this.tiles,
  });
}
