import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/data/vulgus_001.dart';
import 'package:vulgus/game/daily_puzzle_service.dart';
import 'package:vulgus/game/game_controller.dart';
import 'package:vulgus/game/models/game_stats.dart';
import 'package:vulgus/game/stats_repository.dart';
import 'package:vulgus/game/widgets/end_modal.dart';
import 'package:vulgus/theme/app_theme.dart';

ProviderContainer _solvedContainer() {
  final container = ProviderContainer(
    overrides: [
      dailyPuzzleProvider.overrideWithValue(vulgus001),
      statsProvider.overrideWith((_) async => const GameStats()),
    ],
  );
  final ctrl = container.read(gameControllerProvider.notifier);
  for (final cat in container.read(gameControllerProvider).puzzle.categories) {
    for (final w in cat.tiles) {
      ctrl.tap(w);
    }
    ctrl.submit();
  }
  return container;
}

void main() {
  testWidgets('renders win title and copy share button on full solve', (tester) async {
    final container = _solvedContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const Scaffold(body: EndModal())),
    ));
    await tester.pump(); // Let FutureProvider settle.
    expect(find.textContaining('SORTED'), findsOneWidget);
    expect(find.text('COPY SHARE'), findsOneWidget);
    expect(find.text('PLAY AGAIN'), findsNothing);
  });

  testWidgets('copy share button writes text to clipboard', (tester) async {
    final container = _solvedContainer();
    String? copied;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
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
    ));
    await tester.pump();
    await tester.tap(find.text('COPY SHARE'));
    await tester.pump();
    expect(copied, contains('VULGUS VULGUS-001'));
  });
}
