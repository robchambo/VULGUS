import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/theme/app_colors.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  test('palette matches Bauhaus prototype', () {
    expect(AppColors.background, const Color(0xFFF9F9F9));
    expect(AppColors.onSurface, const Color(0xFF1B1B1B));
    expect(AppColors.primary, const Color(0xFFB7102A));
    expect(AppColors.secondaryContainer, const Color(0xFFFFD167));
    expect(AppColors.tertiary, const Color(0xFF006482));
  });

  test('theme uses Space Grotesk for headlines and Manrope for body', () {
    final theme = buildAppTheme();
    expect(theme.textTheme.displayLarge?.fontFamily, contains('Space Grotesk'));
    expect(theme.textTheme.bodyMedium?.fontFamily, contains('Manrope'));
  });

  test('theme has zero border radius default', () {
    final theme = buildAppTheme();
    final shape = theme.cardTheme.shape as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.zero);
  });
}
