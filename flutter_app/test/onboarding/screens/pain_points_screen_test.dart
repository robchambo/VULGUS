import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/pain_points_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('multi-select toggles pain points', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const PainPointsScreen()),
    ));

    await tester.tap(find.textContaining('too sanitised'));
    await tester.tap(find.textContaining('too easy'));
    await tester.pump();

    expect(container.read(onboardingControllerProvider).painPoints.length, 2);
  });
}
