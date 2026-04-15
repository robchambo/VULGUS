import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';
import '../models/difficulty.dart';

class SolvedBanners extends ConsumerWidget {
  const SolvedBanners({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    if (s.solved.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (final id in s.solved) _Banner(categoryId: id),
      ],
    );
  }
}

class _Banner extends ConsumerWidget {
  final String categoryId;
  const _Banner({required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzle = ref.watch(gameControllerProvider).puzzle;
    final cat = puzzle.categories.firstWhere((c) => c.id == categoryId);
    final difficulty = cat.difficulty ?? Difficulty.easy;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: difficulty.bg,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  cat.label.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: difficulty.fg,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                ),
              ),
              Text(
                difficulty.label.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: difficulty.fg,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            cat.tiles.join(' · '),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: difficulty.fg,
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
    );
  }
}
