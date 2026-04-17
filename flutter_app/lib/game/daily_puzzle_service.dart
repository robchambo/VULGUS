import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/puzzle_library.dart';
import 'models/puzzle.dart';

// Day 0 of VULGUS — change to actual launch date before shipping.
final _epoch = DateTime(2026, 1, 1);

class DailyPuzzleService {
  Puzzle todaysPuzzle() {
    final days = _daysFromEpoch();
    return puzzleLibrary[days % puzzleLibrary.length];
  }

  int puzzleNumber() => _daysFromEpoch() + 1;

  String todayKey() {
    final n = DateTime.now();
    return '${n.year}-${n.month.toString().padLeft(2, '0')}-${n.day.toString().padLeft(2, '0')}';
  }

  int _daysFromEpoch() {
    final today = DateTime.now();
    final days = DateTime(today.year, today.month, today.day)
        .difference(_epoch)
        .inDays;
    return days.clamp(0, 999999);
  }
}

final dailyPuzzleServiceProvider =
    Provider<DailyPuzzleService>((ref) => DailyPuzzleService());

final dailyPuzzleProvider = Provider<Puzzle>(
  (ref) => ref.read(dailyPuzzleServiceProvider).todaysPuzzle(),
);

final puzzleNumberProvider = Provider<int>(
  (ref) => ref.read(dailyPuzzleServiceProvider).puzzleNumber(),
);
