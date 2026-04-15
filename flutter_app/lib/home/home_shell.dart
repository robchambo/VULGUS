import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../archive/archive_placeholder.dart';
import '../game/widgets/vulgus_app_bar.dart';
import '../game/widgets/vulgus_bottom_nav.dart';
import '../rules/rules_screen.dart';
import '../stats/stats_placeholder.dart';
import 'game_screen.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});
  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _tab = 0;

  static const _tabs = <Widget>[
    GameScreen(),
    StatsPlaceholder(),
    ArchivePlaceholder(),
    RulesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VulgusAppBar(),
      body: SafeArea(
        top: false,
        child: IndexedStack(index: _tab, children: _tabs),
      ),
      bottomNavigationBar: VulgusBottomNav(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}
