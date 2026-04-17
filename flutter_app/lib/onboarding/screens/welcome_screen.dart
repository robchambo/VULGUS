import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: AppColors.primary, width: 12)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const OnboardingProgressBar(step: 1, total: 2),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'VULGUS',
                        style: t.displayLarge?.copyWith(color: AppColors.primary),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A daily word game for the common people.',
                        style: t.headlineMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sort the sweary. Skip the slurs.',
                        style: t.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          border: Border.all(color: AppColors.onSurface, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HOW TO PLAY',
                              style: t.labelLarge?.copyWith(
                                letterSpacing: 3,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _Rule('Group 16 words into 4 categories.'),
                            const SizedBox(height: 10),
                            _Rule('Each guess reveals the connection — and its etymology.'),
                            const SizedBox(height: 10),
                            _Rule('You get 4 lives. Use them wisely.'),
                            const SizedBox(height: 10),
                            _Rule('A new puzzle drops every day at midnight.'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        label: 'Get started',
                        onPressed: () => context.go('/onboarding/notify'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  final String text;
  const _Rule(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          color: AppColors.primary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
