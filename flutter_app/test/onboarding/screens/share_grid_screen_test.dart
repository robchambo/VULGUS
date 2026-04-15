import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/share_grid_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders share grid + share + continue CTAs', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const ShareGridScreen()),
    ),);
    expect(find.text('SHARE'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
  });
}
