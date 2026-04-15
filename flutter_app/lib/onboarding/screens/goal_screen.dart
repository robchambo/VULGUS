import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_controller.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class GoalScreen extends ConsumerWidget {
  const GoalScreen({super.key});

  static const _options = [
    ('connections_refugee', '🧩', "I'm a Connections refugee"),
    ('language_nerd', '📖', 'I love a good etymology'),
    ('love_a_swear', '🤬', 'I love a good swear'),
    ('daily_ritual', '☕', 'I want a 5-minute daily habit'),
    ('just_curious', '👀', 'Just having a look'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingControllerProvider);
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 2, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text('What brings you to VULGUS?',
                        style: Theme.of(context).textTheme.headlineLarge,),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final (id, emoji, label) in _options)
                            OptionTile(
                              emoji: emoji,
                              label: label,
                              selected: answers.goal == id,
                              onTap: () => ctrl.setGoal(id),
                            ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: answers.goal == null
                          ? null
                          : () => context.go('/onboarding/pain'),
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
