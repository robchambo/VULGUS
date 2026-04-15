import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';
import 'lives_indicator.dart';

class PuzzleHero extends ConsumerWidget {
  const PuzzleHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    final parts = s.puzzle.id.split('-');
    final top = parts.first;
    final num = parts.length > 1 ? parts.last : '';
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DAILY PUZZLE',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.secondary,
                        fontSize: 11,
                        letterSpacing: 3,
                      ),
                ),
                Text(
                  '$top\n$num',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 56,
                        height: 0.9,
                        letterSpacing: -3,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'MISTAKES',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 10, letterSpacing: 2),
              ),
              const SizedBox(height: 6),
              LivesIndicator(mistakes: s.mistakes),
            ],
          ),
        ],
      ),
    );
  }
}
