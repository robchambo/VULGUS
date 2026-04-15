import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool fullWidth;
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null
            ? AppColors.surfaceContainerHigh
            : AppColors.primary,
        foregroundColor: onPressed == null
            ? AppColors.onSurfaceVariant
            : AppColors.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: AppColors.onSurface, width: 2),
        ),
        minimumSize: const Size.fromHeight(56),
      ),
      child: Text(label.toUpperCase()),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}
