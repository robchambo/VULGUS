import 'dart:math';

import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class BauhausBackdrop extends StatelessWidget {
  const BauhausBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 96,
            left: -40,
            child: Transform.rotate(
              angle: pi / 4,
              child: Container(
                width: 112,
                height: 112,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 40,
            right: 32,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.tertiary.withValues(alpha: 0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
