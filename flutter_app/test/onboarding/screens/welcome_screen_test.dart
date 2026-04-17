import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/welcome_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders headline, VULGUS wordmark, and CTA', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const WelcomeScreen()),
    ),);
    expect(find.text('VULGUS'), findsOneWidget);
    expect(find.textContaining('common people'), findsOneWidget);
    expect(find.text('GET STARTED'), findsOneWidget);
  });
}
