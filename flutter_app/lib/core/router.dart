import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/first_launch.dart';
import '../home/home_shell.dart';
import '../onboarding/screens/welcome_screen.dart';
import '../onboarding/screens/notification_priming_screen.dart';

final firstLaunchProvider = FutureProvider<bool>((ref) async {
  return FirstLaunchRepository().isFirstLaunch();
});

GoRouter buildRouter(bool isFirstLaunch) {
  return GoRouter(
    initialLocation: isFirstLaunch ? '/onboarding/welcome' : '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, __) => const HomeShell()),
      GoRoute(path: '/onboarding/welcome', builder: (_, __) => const WelcomeScreen()),
      GoRoute(path: '/onboarding/notify', builder: (_, __) => const NotificationPrimingScreen()),
    ],
  );
}
