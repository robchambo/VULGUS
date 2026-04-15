import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/processing_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('shows building copy and progress indicator', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: buildAppTheme(),
            home: const ProcessingScreen(),
          ),
        ),
      );
      await tester.pump();
      expect(find.textContaining('Building'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
