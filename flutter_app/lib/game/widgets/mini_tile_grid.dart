import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../mini_puzzle_controller.dart';
import '../mini_puzzle_data.dart';

class MiniTileGrid extends ConsumerWidget {
  const MiniTileGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    final ctrl = ref.read(miniPuzzleProvider.notifier);
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      children: [
        for (final tile in s.tiles)
          _Tile(
            word: tile.word,
            selected: s.selected.contains(tile.word),
            solved: s.solvedCategories.contains(tile.categoryId),
            color: miniCategories
                .firstWhere((c) => c.id == tile.categoryId)
                .color,
            onTap: () => ctrl.toggle(tile.word),
          ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final String word;
  final bool selected;
  final bool solved;
  final Color color;
  final VoidCallback onTap;
  const _Tile({
    required this.word,
    required this.selected,
    required this.solved,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = solved
        ? color
        : selected
            ? AppColors.onSurface
            : AppColors.surfaceContainerLowest;
    final fg = solved || selected ? AppColors.onPrimary : AppColors.onSurface;
    return Material(
      color: bg,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.onSurface, width: 2),
      ),
      child: InkWell(
        onTap: solved ? null : onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                word.toUpperCase(),
                style: TextStyle(
                  color: fg, fontWeight: FontWeight.w800, fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
