import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

ThemeData buildAppTheme() {
  final base = ThemeData.light(useMaterial3: true);
  final headline = GoogleFonts.spaceGroteskTextTheme(base.textTheme);
  final body = GoogleFonts.manropeTextTheme(base.textTheme);

  final textTheme = base.textTheme.copyWith(
    displayLarge: headline.displayLarge?.copyWith(
      fontWeight: FontWeight.w900, color: AppColors.onSurface,
      letterSpacing: -2,
    ),
    displayMedium: headline.displayMedium?.copyWith(
      fontWeight: FontWeight.w900, color: AppColors.onSurface,
    ),
    headlineLarge: headline.headlineLarge?.copyWith(
      fontWeight: FontWeight.w800, color: AppColors.onSurface,
    ),
    headlineMedium: headline.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700, color: AppColors.onSurface,
    ),
    titleLarge: headline.titleLarge?.copyWith(
      fontWeight: FontWeight.w700, color: AppColors.onSurface,
    ),
    bodyLarge: body.bodyLarge?.copyWith(color: AppColors.onSurface),
    bodyMedium: body.bodyMedium?.copyWith(color: AppColors.onSurface),
    labelLarge: GoogleFonts.spaceGrotesk(
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
        textStyle: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: 1.2,
        ),
      ),
    ),
  );
}
