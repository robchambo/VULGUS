import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';
import '../share_text.dart';

class EndModal extends ConsumerWidget {
  const EndModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    if (!s.isOver) return const SizedBox.shrink();
    final t = Theme.of(context).textTheme;
    final share = buildShareText(
      puzzleId: s.puzzle.id,
      guesses: s.guesses,
      solved: s.solved.length.clamp(0, s.puzzle.categories.length),
      mistakes: s.mistakes,
    );
    final title = s.isWon ? 'SORTED THE SWEARY.' : 'TRY TOMORROW.';
    final body = s.isWon
        ? 'Done in ${s.guesses.length} guesses, ${s.mistakes} mistake${s.mistakes == 1 ? '' : 's'}.'
        : 'Ran out of lives after ${s.guesses.length} guesses.';

    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          border: Border.all(color: AppColors.onSurface, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RESULT',
              style: t.labelLarge?.copyWith(color: AppColors.secondary, letterSpacing: 3),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: t.displayMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
                height: 0.95,
              ),
            ),
            const SizedBox(height: 16),
            Text(body, style: t.bodyMedium),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.surfaceContainerHigh,
              child: Text(
                buildShareGrid(s.guesses),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 20,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Clipboard.setData(ClipboardData(text: share)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tertiary,
                      foregroundColor: AppColors.onTertiary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: AppColors.onSurface, width: 2),
                      ),
                      minimumSize: const Size.fromHeight(48),
                      elevation: 0,
                    ),
                    child: const Text('COPY SHARE'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => ref.invalidate(gameControllerProvider),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.onSurface,
                      side: const BorderSide(color: AppColors.onSurface, width: 2),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text('PLAY AGAIN'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
