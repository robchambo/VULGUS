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
              const OnboardingProgressBar(step: 1, total: 11),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text('VULGUS',
                          style: t.displayLarge?.copyWith(color: AppColors.primary)),
                      const SizedBox(height: 12),
                      Text(
                        'A daily word game for the common people.',
                        style: t.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sort the sweary. Skip the slurs.',
                        style: t.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 220),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryContainer,
                              border: Border.all(color: AppColors.onSurface, width: 2),
                            ),
                            child: const Center(
                              child: Icon(Icons.grid_view,
                                  size: 96, color: AppColors.onSurface),
                            ),
                          ),
                        ),
                      ),
                      PrimaryButton(
                        label: 'Get started',
                        onPressed: () => context.go('/onboarding/goal'),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () => context.go('/onboarding/account'),
                          child: const Text('I already have an account'),
                        ),
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
