import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_controller.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class PainPointsScreen extends ConsumerWidget {
  const PainPointsScreen({super.key});

  static const _options = [
    ('too_sanitised', '🥱', 'Other word games are too sanitised'),
    ('too_easy', '😴', 'Wordle/Connections feel too easy'),
    ('repetitive', '🔁', 'They get repetitive fast'),
    ('no_learning', '🧠', "I don't learn anything from them"),
    ('no_ritual', '⏰', 'No proper daily ritual'),
    ('ugly_design', '🎨', 'Ugly, generic design'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingControllerProvider);
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 3, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text('What annoys you about other word games?',
                        style: Theme.of(context).textTheme.headlineLarge,),
                    const SizedBox(height: 8),
                    Text('Pick as many as you like.',
                        style: Theme.of(context).textTheme.bodyMedium,),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final (id, emoji, label) in _options)
                            OptionTile(
                              emoji: emoji,
                              label: label,
                              selected: answers.painPoints.contains(id),
                              onTap: () => ctrl.togglePainPoint(id),
                            ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: answers.painPoints.isEmpty
                          ? null
                          : () => context.go('/onboarding/tinder'),
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
