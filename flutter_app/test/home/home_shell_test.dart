import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/home/home_shell.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('Play tab is active by default and shows daily puzzle hero',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const HomeShell()),
    ),);
    expect(find.textContaining('DAILY PUZZLE'), findsOneWidget);
  });

  testWidgets('tapping Rules tab switches body', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const HomeShell()),
    ),);
    await tester.tap(find.text('RULES'));
    await tester.pumpAndSettle();
    expect(find.textContaining('HOW TO PLAY'), findsOneWidget);
  });
}
