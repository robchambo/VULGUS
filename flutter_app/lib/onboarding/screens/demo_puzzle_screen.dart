import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../game/mini_puzzle_controller.dart';
import '../../game/widgets/etymology_strip.dart';
import '../../game/widgets/tile_grid.dart';
import '../../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class DemoPuzzleScreen extends ConsumerWidget {
  const DemoPuzzleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    final ctrl = ref.read(miniPuzzleProvider.notifier);

    if (s.isComplete || s.isFailed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/onboarding/share');
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 8, total: 11),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Try a mini-puzzle.\nSort 8 words into 2 groups of 4.',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'LIVES',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          for (var i = 0; i < 4; i++)
                            Container(
                              width: 14,
                              height: 14,
                              margin: const EdgeInsets.only(left: 4),
                              color: i < s.lives
                                  ? AppColors.onSurface
                                  : AppColors.surfaceContainerHigh,
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TileGrid(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: EtymologyStrip(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: 'Submit',
                onPressed: s.selected.length == 4 ? ctrl.submit : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
