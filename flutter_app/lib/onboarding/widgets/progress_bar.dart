import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class OnboardingProgressBar extends StatelessWidget {
  final int step;
  final int total;
  const OnboardingProgressBar({super.key, required this.step, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        border: Border(bottom: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: (step / total).clamp(0.0, 1.0),
          child: Container(color: AppColors.primary),
        ),
      ),
    );
  }
}
