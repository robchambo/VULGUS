import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app.dart';
import 'notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    // Anonymous auth — ensure every session has a UID
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
  } catch (_) {
    // Firebase not available (test environment or missing config)
  }

  await MobileAds.instance.initialize();
  try {
    await NotificationService.initialize();
    final notifGranted = await Permission.notification.isGranted;
    if (notifGranted) {
      await NotificationService.scheduleDailyReminder();
    }
  } catch (_) {
    // Notification setup not available (web/test)
  }
  runApp(const ProviderScope(child: VulgusApp()));
}
