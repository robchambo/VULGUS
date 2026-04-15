import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/first_launch.dart';
import '../../theme/app_colors.dart';
import '../onboarding_controller.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class EarlyAccessScreen extends ConsumerStatefulWidget {
  const EarlyAccessScreen({super.key});
  @override
  ConsumerState<EarlyAccessScreen> createState() => _EarlyAccessScreenState();
}

class _EarlyAccessScreenState extends ConsumerState<EarlyAccessScreen> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _finish({bool capture = true}) async {
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    if (capture && _email.text.trim().isNotEmpty) {
      ctrl.setEmail(_email.text.trim());
    }
    await ctrl.persist();
    await FirstLaunchRepository().markCompleted();
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 11, total: 11),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'VULGUS+',
                      style: t.displayMedium?.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 8),
                    Text('Coming soon. Want first dibs?', style: t.headlineSmall),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        border: Border.all(color: AppColors.onSurface, width: 2),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Bullet('Full archive of every past puzzle'),
                          SizedBox(height: 8),
                          _Bullet('Themed packs (Shakespearean Week, Minced Oaths…)'),
                          SizedBox(height: 8),
                          _Bullet('Stats, streak protection, deeper etymologies'),
                          SizedBox(height: 8),
                          _Bullet('Mild Mode for the family/office crowd'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        border: Border.all(color: AppColors.onSurface, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PLANNED PRICING', style: t.labelLarge),
                          const SizedBox(height: 8),
                          Text(
                            '£2.99 / mo  ·  £19.99 / yr  ·  £49.99 lifetime',
                            style: t.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Free daily puzzle, forever. No card now.',
                            style: t.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email (optional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: AppColors.onSurface, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(label: 'Notify me', onPressed: () => _finish()),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => _finish(capture: false),
                        child: const Text('Just take me to the puzzle'),
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
