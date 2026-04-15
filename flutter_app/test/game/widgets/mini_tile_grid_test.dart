import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/game/mini_puzzle_controller.dart';
import 'package:vulgus/game/widgets/mini_tile_grid.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders 8 tile widgets', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: MiniTileGrid()),
      ),
    ),);
    expect(find.byType(InkWell), findsNWidgets(8));
  });

  testWidgets('tapping a tile selects it (visual change)', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: MiniTileGrid()),
      ),
    ),);
    final firstWord = container.read(miniPuzzleProvider).tiles.first.word;
    await tester.tap(find.text(firstWord.toUpperCase()));
    await tester.pump();
    expect(container.read(miniPuzzleProvider).selected, contains(firstWord));
  });
}
