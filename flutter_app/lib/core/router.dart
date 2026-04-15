import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/first_launch.dart';
import '../home/home_placeholder.dart';
import '../onboarding/screens/welcome_screen.dart';
import '../onboarding/screens/goal_screen.dart';
import '../onboarding/screens/pain_points_screen.dart';
import '../onboarding/screens/tinder_screen.dart';
import '../onboarding/screens/preference_screen.dart';
import '../onboarding/screens/notification_priming_screen.dart';
import '../onboarding/screens/processing_screen.dart';
import '../onboarding/screens/demo_puzzle_screen.dart';
import '../onboarding/screens/share_grid_screen.dart';
import '../onboarding/screens/account_screen.dart';
import '../onboarding/screens/early_access_screen.dart';

final firstLaunchProvider = FutureProvider<bool>((ref) async {
  return FirstLaunchRepository().isFirstLaunch();
});

GoRouter buildRouter(bool isFirstLaunch) {
  return GoRouter(
    initialLocation: isFirstLaunch ? '/onboarding/welcome' : '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, __) => const HomePlaceholder()),
      GoRoute(path: '/onboarding/welcome', builder: (_, __) => const WelcomeScreen()),
      GoRoute(path: '/onboarding/goal', builder: (_, __) => const GoalScreen()),
      GoRoute(path: '/onboarding/pain', builder: (_, __) => const PainPointsScreen()),
      GoRoute(path: '/onboarding/tinder', builder: (_, __) => const TinderScreen()),
      GoRoute(path: '/onboarding/preference', builder: (_, __) => const PreferenceScreen()),
      GoRoute(path: '/onboarding/notify', builder: (_, __) => const NotificationPrimingScreen()),
      GoRoute(path: '/onboarding/processing', builder: (_, __) => const ProcessingScreen()),
      GoRoute(path: '/onboarding/demo', builder: (_, __) => const DemoPuzzleScreen()),
      GoRoute(path: '/onboarding/share', builder: (_, __) => const ShareGridScreen()),
      GoRoute(path: '/onboarding/account', builder: (_, __) => const AccountScreen()),
      GoRoute(path: '/onboarding/early-access', builder: (_, __) => const EarlyAccessScreen()),
    ],
  );
}
