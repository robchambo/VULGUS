import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vulgus/theme/app_colors.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  test('palette matches Bauhaus prototype', () {
    expect(AppColors.background, const Color(0xFFF9F9F9));
    expect(AppColors.onSurface, const Color(0xFF1B1B1B));
    expect(AppColors.primary, const Color(0xFFB7102A));
    expect(AppColors.secondaryContainer, const Color(0xFFFFD167));
    expect(AppColors.tertiary, const Color(0xFF006482));
  });

  testWidgets('theme uses Space Grotesk for headlines and Manrope for body',
      (tester) async {
    final theme = buildAppTheme();
    expect(theme.textTheme.displayLarge?.fontFamily, contains('SpaceGrotesk'));
    expect(theme.textTheme.bodyMedium?.fontFamily, contains('Manrope'));
  });

  testWidgets('theme has zero border radius default', (tester) async {
    final theme = buildAppTheme();
    final shape = theme.cardTheme.shape as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.zero);
  });
}
