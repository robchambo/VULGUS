import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../mini_puzzle_controller.dart';
import '../mini_puzzle_data.dart';

/// 2x4 Bauhaus shape grid summarising the player's solve.
/// Each row = one category. Filled square = correct, hollow = lost a life on it.
class ShareGrid extends ConsumerWidget {
  const ShareGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        children: [
          Text(
            'VULGUS · WARM-UP',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          for (final cat in miniCategories)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 4; i++)
                    Container(
                      width: 28,
                      height: 28,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: s.solvedCategories.contains(cat.id)
                            ? cat.color
                            : Colors.transparent,
                        border: Border.all(color: AppColors.onSurface, width: 2),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Text(
            'Lives left: ${s.lives}/4',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
