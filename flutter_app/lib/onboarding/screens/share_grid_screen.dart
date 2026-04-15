import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../game/mini_puzzle_controller.dart';
import '../../game/mini_puzzle_data.dart';
import '../../game/widgets/mini_share_grid.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class ShareGridScreen extends ConsumerWidget {
  const ShareGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    final shareText = _buildShareText(s.solvedCategories.length, s.lives);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 9, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      s.solvedCategories.length == miniCategories.length
                          ? 'Nice. You sorted them all.'
                          : 'Close — the real puzzles are tougher.',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const MiniShareGrid(),
                    const Spacer(),
                    PrimaryButton(
                      label: 'Share',
                      onPressed: () => Clipboard.setData(
                        ClipboardData(text: shareText),
                      ),
                    ),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: () => context.go('/onboarding/account'),
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

  String _buildShareText(int solved, int lives) =>
      'VULGUS warm-up: $solved/${miniCategories.length} · $lives lives left\n'
      'A daily word game for the common people.\n'
      'https://vulgus.app';
}
