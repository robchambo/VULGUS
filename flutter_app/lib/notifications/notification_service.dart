import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static const _skip = bool.fromEnvironment('DANGEROUSLY_SKIP_PERMISSIONS');
  static final _plugin = FlutterLocalNotificationsPlugin();
  static const _dailyId = 0;

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
  }

  Future<bool> requestPermission() async {
    if (_skip) return true;
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  static Future<void> scheduleDailyReminder() async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'daily_reminder',
      'Daily Puzzle Reminder',
      channelDescription: 'Reminds you when the daily VULGUS puzzle is ready',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const details = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      _dailyId,
      'VULGUS',
      'Your daily puzzle is ready. Sort the sweary.',
      scheduled,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelReminder() async {
    await _plugin.cancel(_dailyId);
  }
}
