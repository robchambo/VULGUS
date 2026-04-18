import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/user_repository.dart';
import 'models/game_stats.dart';

class StatsRepository {
  static const _statsKey = 'game_stats_v1';
  static const _todayPlayKey = 'today_play_v1';
  static const _playedDatesKey = 'played_dates_v1';

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String get _today => _dateKey(DateTime.now());
  String get _yesterday => _dateKey(DateTime.now().subtract(const Duration(days: 1)));

  Future<GameStats> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_statsKey);
    if (raw == null) return const GameStats();
    return GameStats.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<TodayResult?> todayResult() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_todayPlayKey);
    if (raw == null) return null;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    if ((map['date'] as String?) != _today) return null;
    return TodayResult.fromJson(map);
  }

  Future<void> recordResult({
    required bool won,
    required String shareGrid,
    required String shareText,
    required int guesses,
    required int mistakes,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Guard against double-recording on the same day.
    final existing = prefs.getString(_todayPlayKey);
    if (existing != null) {
      final map = jsonDecode(existing) as Map<String, dynamic>;
      if ((map['date'] as String?) == _today) return;
    }

    final payload = {
      'date': _today,
      ...TodayResult(
        won: won,
        shareGrid: shareGrid,
        shareText: shareText,
        guesses: guesses,
        mistakes: mistakes,
      ).toJson(),
    };
    await prefs.setString(_todayPlayKey, jsonEncode(payload));

    final stats = await loadStats();
    final int newStreak;
    if (!won) {
      newStreak = 0;
    } else if (stats.lastPlayedDate == _yesterday) {
      newStreak = stats.currentStreak + 1;
    } else {
      newStreak = 1;
    }

    final updated = GameStats(
      gamesPlayed: stats.gamesPlayed + 1,
      gamesWon: won ? stats.gamesWon + 1 : stats.gamesWon,
      currentStreak: newStreak,
      maxStreak: newStreak > stats.maxStreak ? newStreak : stats.maxStreak,
      lastPlayedDate: _today,
    );
    await prefs.setString(_statsKey, jsonEncode(updated.toJson()));

    await _savePlayedDate(_today);

    // Sync to Firestore (fire-and-forget — don't block the UI)
    try {
      final userRepo = UserRepository(
        FirebaseFirestore.instance,
        FirebaseAuth.instance,
      );
      final stats = await loadStats();
      final dates = await loadPlayedDates();
      userRepo.syncStats(stats, dates); // fire-and-forget
    } catch (_) {
      // Firestore sync failed — data is safe locally
    }
  }

  Future<Set<String>> loadPlayedDates() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_playedDatesKey);
    return raw?.toSet() ?? {};
  }

  Future<void> _savePlayedDate(String dateKey) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_playedDatesKey) ?? [];
    final updated = {...existing, dateKey}.toList();
    await prefs.setStringList(_playedDatesKey, updated);
  }
}

final statsRepositoryProvider =
    Provider<StatsRepository>((ref) => StatsRepository());

final statsProvider = FutureProvider<GameStats>(
  (ref) => ref.read(statsRepositoryProvider).loadStats(),
);

final todayResultProvider = FutureProvider<TodayResult?>(
  (ref) => ref.read(statsRepositoryProvider).todayResult(),
);

final playedDatesProvider = FutureProvider<Set<String>>(
  (ref) => ref.read(statsRepositoryProvider).loadPlayedDates(),
);
