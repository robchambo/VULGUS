import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game/models/game_stats.dart';

class UserRepository {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  UserRepository(this._db, this._auth);

  String? get _uid => _auth.currentUser?.uid;

  DocumentReference? get _userDoc =>
      _uid != null ? _db.collection('users').doc(_uid) : null;

  /// Sync local stats to Firestore (merge — doesn't overwrite server data).
  Future<void> syncStats(GameStats stats, Set<String> playedDates) async {
    final doc = _userDoc;
    if (doc == null) return;
    await doc.set({
      'stats': stats.toJson(),
      'playedDates': playedDates.toList(),
      'lastSyncedAt': FieldValue.serverTimestamp(),
      'email': _auth.currentUser?.email,
      'displayName': _auth.currentUser?.displayName,
      'isAnonymous': _auth.currentUser?.isAnonymous ?? true,
    }, SetOptions(merge: true),);
  }

  /// Pull stats from Firestore (for cross-device sync).
  Future<({GameStats stats, Set<String> playedDates})?> fetchStats() async {
    final doc = _userDoc;
    if (doc == null) return null;
    final snap = await doc.get();
    if (!snap.exists) return null;
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) return null;
    final statsMap = data['stats'] as Map<String, dynamic>?;
    final datesRaw = data['playedDates'] as List<dynamic>?;
    return (
      stats: statsMap != null
          ? GameStats.fromJson(statsMap)
          : const GameStats(),
      playedDates: datesRaw?.cast<String>().toSet() ?? {},
    );
  }

  /// Save the early-access email from onboarding.
  Future<void> saveEarlyAccessEmail(String email) async {
    final doc = _userDoc;
    if (doc == null) return;
    await doc.set({
      'earlyAccessEmail': email,
      'emailCapturedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true),);
  }
}

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(FirebaseFirestore.instance, FirebaseAuth.instance),
);
