import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulgus/app.dart';

void main() {
  testWidgets('routes to /onboarding/welcome when first launch', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: VulgusApp()));
    await tester.pumpAndSettle();
    expect(find.textContaining('common people'), findsOneWidget);
  });

  testWidgets('routes to /home when onboarding complete', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({'onboarding_completed_v1': true});
    await tester.pumpWidget(const ProviderScope(child: VulgusApp()));
    await tester.pumpAndSettle();
    expect(find.textContaining('DAILY PUZZLE'), findsOneWidget);
  });
}
