import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/game_controller.dart';
import 'package:vulgus/game/widgets/daily_tile_grid.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders 16 active tile buttons initially', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: DailyTileGrid()),
      ),
    ));
    expect(find.byType(InkWell), findsNWidgets(16));
  });

  testWidgets('tapping a tile selects it in the controller', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: DailyTileGrid()),
      ),
    ));
    final first = container.read(gameControllerProvider).activeTiles.first;
    await tester.tap(find.text(first));
    await tester.pump();
    expect(container.read(gameControllerProvider).selected, contains(first));
  });

  testWidgets('after solving one category, only 12 tiles are shown', (tester) async {
    final container = ProviderContainer();
    final ctrl = container.read(gameControllerProvider.notifier);
    final cat = container.read(gameControllerProvider).puzzle.categories.first;
    for (final w in cat.tiles) {
      ctrl.tap(w);
    }
    ctrl.submit();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: DailyTileGrid()),
      ),
    ));
    expect(find.byType(InkWell), findsNWidgets(12));
  });
}
