import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/auth_service.dart';
import '../../theme/app_colors.dart';
import '../widgets/progress_bar.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    Future<void> next() async => context.go('/onboarding/early-access');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 10, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Save your streak',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Free account. Keeps your streak across devices and unlocks VULGUS+ when it launches.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    _AuthButton(
                      icon: Icons.apple,
                      label: 'Continue with Apple',
                      bg: AppColors.onSurface,
                      fg: AppColors.onPrimary,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Coming soon — Apple Sign-In requires an Apple Developer account',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _AuthButton(
                      icon: Icons.g_mobiledata,
                      label: 'Continue with Google',
                      bg: AppColors.surfaceContainerLowest,
                      fg: AppColors.onSurface,
                      onPressed: () async {
                        try {
                          await authRepo.signInWithGoogle();
                        } catch (_) {
                          // Sign-in cancelled or failed — stay on screen
                          return;
                        }
                        if (context.mounted) await next();
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: next,
                        child: const Text('Skip for now'),
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

class _AuthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onPressed;
  const _AuthButton({
    required this.icon,
    required this.label,
    required this.bg,
    required this.fg,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: fg),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          minimumSize: const Size.fromHeight(56),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: AppColors.onSurface, width: 2),
          ),
        ),
      ),
    );
  }
}
