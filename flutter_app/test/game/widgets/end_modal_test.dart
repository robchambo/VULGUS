import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/game_controller.dart';
import 'package:vulgus/game/widgets/end_modal.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders win title + share grid + buttons on full solve', (tester) async {
    final container = ProviderContainer();
    final ctrl = container.read(gameControllerProvider.notifier);
    for (final cat in container.read(gameControllerProvider).puzzle.categories) {
      for (final w in cat.tiles) {
        ctrl.tap(w);
      }
      ctrl.submit();
    }
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const Scaffold(body: EndModal())),
    ),);
    expect(find.textContaining('SORTED'), findsOneWidget);
    expect(find.text('COPY SHARE'), findsOneWidget);
    expect(find.text('PLAY AGAIN'), findsOneWidget);
  });

  testWidgets('copy share button writes text to clipboard', (tester) async {
    final container = ProviderContainer();
    final ctrl = container.read(gameControllerProvider.notifier);
    for (final cat in container.read(gameControllerProvider).puzzle.categories) {
      for (final w in cat.tiles) {
        ctrl.tap(w);
      }
      ctrl.submit();
    }
    String? copied;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const Scaffold(body: EndModal())),
    ),);
    await tester.tap(find.text('COPY SHARE'));
    await tester.pump();
    expect(copied, contains('VULGUS VULGUS-001'));
  });
}
