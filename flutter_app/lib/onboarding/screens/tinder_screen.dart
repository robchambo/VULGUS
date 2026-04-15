import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_controller.dart';
import '../widgets/progress_bar.dart';
import '../widgets/tinder_card.dart';

class TinderScreen extends ConsumerStatefulWidget {
  const TinderScreen({super.key});
  @override
  ConsumerState<TinderScreen> createState() => _TinderScreenState();
}

class _TinderScreenState extends ConsumerState<TinderScreen> {
  static const _statements = [
    "I've definitely Googled where a swear word comes from.",
    "Connections is too tame for me.",
    "I want a word game I can do over my morning coffee.",
    "I'd rather be sweary than safe.",
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    if (_index >= _statements.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/onboarding/preference');
      });
      return const SizedBox.shrink();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 4, total: 11),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Which of these sounds like you?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TinderCard(
                    key: ValueKey(_index),
                    statement: _statements[_index],
                    onSwiped: (agree) {
                      ctrl.recordTinder(agree);
                      setState(() => _index++);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Card ${_index + 1} of ${_statements.length}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
