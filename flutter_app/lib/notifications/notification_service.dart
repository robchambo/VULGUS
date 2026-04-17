import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  // Pass --dart-define=DANGEROUSLY_SKIP_PERMISSIONS=true to bypass OS dialogs in testing.
  static const _skip =
      bool.fromEnvironment('DANGEROUSLY_SKIP_PERMISSIONS');

  Future<bool> requestPermission() async {
    if (_skip) return true;
    final status = await Permission.notification.request();
    return status.isGranted;
  }
}
