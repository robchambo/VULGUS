import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../notifications/notification_service.dart';
import '../../theme/app_colors.dart';
import '../onboarding_controller.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class NotificationPrimingScreen extends ConsumerWidget {
  const NotificationPrimingScreen({super.key});

  Future<void> _enable(BuildContext context, WidgetRef ref) async {
    final granted = await NotificationService().requestPermission();
    ref
        .read(onboardingControllerProvider.notifier)
        .setNotificationsRequested(granted);
    if (context.mounted) context.go('/onboarding/processing');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 6, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Never miss the daily drop',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        border: Border.all(color: AppColors.onSurface, width: 2),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Bullet('A new puzzle every morning at 9am'),
                          SizedBox(height: 12),
                          _Bullet('A nudge if you forget — keep your streak alive'),
                          SizedBox(height: 12),
                          _Bullet('No spam. Ever. Just the one ping.'),
                        ],
                      ),
                    ),
                    const Spacer(),
                    PrimaryButton(
                      label: 'Enable notifications',
                      onPressed: () => _enable(context, ref),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => context.go('/onboarding/processing'),
                        child: const Text('Not now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('▪️ ', style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
