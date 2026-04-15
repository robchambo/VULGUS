import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class OptionTile extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const OptionTile({
    super.key,
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.onSurface : AppColors.surfaceContainerLowest,
          border: Border.all(color: AppColors.onSurface, width: 2),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: selected ? AppColors.onPrimary : AppColors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            if (selected)
              const Icon(Icons.check, color: AppColors.onPrimary, size: 24),
          ],
        ),
      ),
    );
  }
}
