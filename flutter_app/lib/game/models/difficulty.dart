import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

enum Difficulty {
  easy,
  medium,
  hard,
  trickiest,
  ;

  String get label => switch (this) {
        Difficulty.easy => 'Easy',
        Difficulty.medium => 'Medium',
        Difficulty.hard => 'Hard',
        Difficulty.trickiest => 'Trickiest',
      };

  Color get bg => switch (this) {
        Difficulty.easy => AppColors.secondaryContainer,
        Difficulty.medium => AppColors.tertiary,
        Difficulty.hard => AppColors.primary,
        Difficulty.trickiest => AppColors.onSurface,
      };

  Color get fg => switch (this) {
        Difficulty.easy => AppColors.onSecondaryContainer,
        Difficulty.medium => AppColors.onTertiary,
        Difficulty.hard => AppColors.onPrimary,
        Difficulty.trickiest => AppColors.surface,
      };
}
