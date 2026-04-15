import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ArchivePlaceholder extends StatelessWidget {
  const ArchivePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'COMING SOON',
            style: t.labelLarge?.copyWith(color: AppColors.secondary, letterSpacing: 3),
          ),
          const SizedBox(height: 4),
          Text(
            'ARCHIVE',
            style: t.displayLarge?.copyWith(fontSize: 56, height: 0.9, letterSpacing: -2),
          ),
          const SizedBox(height: 16),
          Text(
            'Every past VULGUS puzzle will live here. Unlocked with VULGUS+.',
            style: t.bodyLarge,
          ),
        ],
      ),
    );
  }
}
