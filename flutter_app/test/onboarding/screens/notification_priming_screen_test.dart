import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/notification_priming_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders headline and both CTAs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildAppTheme(),
          home: const NotificationPrimingScreen(),
        ),
      ),
    );
    expect(find.textContaining('Never miss'), findsOneWidget);
    expect(find.text('ENABLE NOTIFICATIONS'), findsOneWidget);
    expect(find.text('Not now'), findsOneWidget);
  });
}
