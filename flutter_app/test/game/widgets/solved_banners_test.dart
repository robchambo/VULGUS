import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/game/game_controller.dart';
import 'package:vulgus/game/widgets/solved_banners.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('shows one banner per solved category with label + words', (tester) async {
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
        home: const Scaffold(body: SolvedBanners()),
      ),
    ),);
    expect(find.textContaining(cat.label.toUpperCase()), findsOneWidget);
    expect(find.textContaining(cat.tiles.first), findsOneWidget);
  });
}
