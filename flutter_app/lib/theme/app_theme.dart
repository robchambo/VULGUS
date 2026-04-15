import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData buildAppTheme() {
  final base = ThemeData.light(useMaterial3: true);

  final textTheme = base.textTheme.copyWith(
    displayLarge: base.textTheme.displayLarge?.copyWith(
      fontFamily: 'Space Grotesk',
      fontWeight: FontWeight.w900,
      color: AppColors.onSurface,
      letterSpacing: -2,
    ),
    displayMedium: base.textTheme.displayMedium?.copyWith(
      fontFamily: 'Space Grotesk',
      fontWeight: FontWeight.w900,
      color: AppColors.onSurface,
    ),
    headlineLarge: base.textTheme.headlineLarge?.copyWith(
      fontFamily: 'Space Grotesk',
      fontWeight: FontWeight.w800,
      color: AppColors.onSurface,
    ),
    headlineMedium: base.textTheme.headlineMedium?.copyWith(
      fontFamily: 'Space Grotesk',
      fontWeight: FontWeight.w700,
      color: AppColors.onSurface,
    ),
    titleLarge: base.textTheme.titleLarge?.copyWith(
      fontFamily: 'Space Grotesk',
      fontWeight: FontWeight.w700,
      color: AppColors.onSurface,
    ),
    bodyLarge: base.textTheme.bodyLarge?.copyWith(
      fontFamily: 'Manrope',
      color: AppColors.onSurface,
    ),
    bodyMedium: base.textTheme.bodyMedium?.copyWith(
      fontFamily: 'Manrope',
      color: AppColors.onSurface,
    ),
    labelLarge: base.textTheme.labelLarge?.copyWith(
      fontFamily: 'Space Grotesk',
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: AppColors.onSurface,
    ),
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondaryContainer,
      onSecondary: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
      onError: Colors.white,
    ),
    textTheme: textTheme,
    cardTheme: const CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: AppColors.surfaceContainerLowest,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        textStyle: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w800,
          fontSize: 16,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );
}
