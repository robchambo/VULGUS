import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/tinder_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('tapping check records agree', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const TinderScreen()),
    ),);
    await tester.tap(find.byIcon(Icons.check));
    await tester.pump();
    expect(container.read(onboardingControllerProvider).tinderResponses,
        contains(true),);
  });
}
