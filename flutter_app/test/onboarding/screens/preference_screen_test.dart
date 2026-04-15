import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/preference_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('tapping a category card toggles selection', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const PreferenceScreen()),
    ),);
    await tester.tap(find.textContaining('British'));
    await tester.pump();
    expect(container.read(onboardingControllerProvider).categoryPreferences,
        contains('british'),);
  });
}
