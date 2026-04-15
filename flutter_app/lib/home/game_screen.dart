import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game/widgets/action_bar.dart';
import '../game/widgets/bauhaus_backdrop.dart';
import '../game/widgets/daily_etymology_strip.dart';
import '../game/widgets/daily_tile_grid.dart';
import '../game/widgets/end_modal.dart';
import '../game/widgets/puzzle_hero.dart';
import '../game/widgets/solved_banners.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Stack(
      children: [
        BauhausBackdrop(),
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PuzzleHero(),
              SizedBox(height: 16),
              SolvedBanners(),
              DailyTileGrid(),
              SizedBox(height: 12),
              DailyEtymologyStrip(),
              SizedBox(height: 16),
              ActionBar(),
            ],
          ),
        ),
        EndModal(),
      ],
    );
  }
}
