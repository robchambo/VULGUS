import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class VulgusBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const VulgusBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _items = <({IconData icon, String label})>[
    (icon: Icons.play_arrow, label: 'PLAY'),
    (icon: Icons.leaderboard, label: 'STATS'),
    (icon: Icons.history, label: 'ARCHIVE'),
    (icon: Icons.menu_book, label: 'RULES'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < _items.length; i++)
            Expanded(
              child: _Tab(
                icon: _items[i].icon,
                label: _items[i].label,
                active: i == currentIndex,
                onTap: () => onTap(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Tab({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = active ? AppColors.tertiary : AppColors.surface;
    final fg = active ? AppColors.onTertiary : AppColors.onSurface;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: bg,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: fg, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: fg,
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
