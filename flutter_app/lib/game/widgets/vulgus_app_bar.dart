import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class VulgusAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenu;
  final VoidCallback? onHelp;
  const VulgusAppBar({super.key, this.onMenu, this.onHelp});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      child: Row(
        children: [
          _IconButton(icon: Icons.grid_view, onPressed: onMenu, semanticLabel: 'Menu'),
          const Spacer(),
          Text(
            'VULGUS',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
          ),
          const Spacer(),
          _IconButton(icon: Icons.help_outline, onPressed: onHelp, semanticLabel: 'How to play'),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String semanticLabel;
  const _IconButton({required this.icon, required this.onPressed, required this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: AppColors.onSurface, size: 28, semanticLabel: semanticLabel),
      ),
    );
  }
}
