import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../onboarding_controller.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class PreferenceScreen extends ConsumerWidget {
  const PreferenceScreen({super.key});

  static const _categories = [
    ('british', '🇬🇧', 'British classics'),
    ('soft', '☁️', 'Soft swears'),
    ('minced', '🥧', 'Minced oaths'),
    ('scifi', '🚀', 'Sci-fi fictional'),
    ('eponymous', '👤', 'Eponymous'),
    ('shakespeare', '🎭', 'Shakespearean'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingControllerProvider);
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 5, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Pick your favourite vibes',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We'll lean into these in your puzzles.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: [
                          for (final (id, emoji, label) in _categories)
                            _CategoryCard(
                              emoji: emoji,
                              label: label,
                              selected: answers.categoryPreferences.contains(id),
                              onTap: () => ctrl.toggleCategory(id),
                            ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: answers.categoryPreferences.isEmpty
                          ? null
                          : () => context.go('/onboarding/notify'),
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

class _CategoryCard extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _CategoryCard({
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? AppColors.secondaryContainer
              : AppColors.surfaceContainerLowest,
          border: Border.all(color: AppColors.onSurface, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
