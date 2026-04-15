import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/goal_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('selecting an option enables Continue and stores answer',
      (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const GoalScreen()),
    ));
    expect(find.text('CONTINUE'), findsOneWidget);

    await tester.tap(find.textContaining('Connections refugee'));
    await tester.pump();

    expect(container.read(onboardingControllerProvider).goal, isNotNull);
  });
}
