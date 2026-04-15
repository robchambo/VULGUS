import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../mini_puzzle_controller.dart';
import '../mini_puzzle_data.dart';

class MiniEtymologyStrip extends ConsumerWidget {
  const MiniEtymologyStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    if (s.solvedCategories.isEmpty) {
      return Container(
        constraints: const BoxConstraints(minHeight: 96),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          border: Border.all(color: AppColors.onSurface, width: 2),
        ),
        child: Center(
          child: Text(
            'Solve a category to reveal its etymology.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final last = miniCategories.firstWhere(
      (c) => c.id == s.solvedCategories.last,
    );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: last.color,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            last.label.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Text(
            last.etymology,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
