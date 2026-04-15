import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class LivesIndicator extends StatelessWidget {
  final int mistakes;
  const LivesIndicator({super.key, required this.mistakes});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 4; i++)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: i < 4 - mistakes
                ? Container(width: 16, height: 16, color: AppColors.onSurface)
                : Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.onSurface, width: 2),
                    ),
                  ),
          ),
      ],
    );
  }
}
