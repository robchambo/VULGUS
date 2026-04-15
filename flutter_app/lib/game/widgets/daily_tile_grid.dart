import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';

class DailyTileGrid extends ConsumerStatefulWidget {
  const DailyTileGrid({super.key});
  @override
  ConsumerState<DailyTileGrid> createState() => _DailyTileGridState();
}

class _DailyTileGridState extends ConsumerState<DailyTileGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shake;
  int _lastGuessCount = 0;

  @override
  void initState() {
    super.initState();
    _shake = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
  }

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(gameControllerProvider);
    final ctrl = ref.read(gameControllerProvider.notifier);

    if (s.guesses.length > _lastGuessCount) {
      final lastWrong = !s.guesses.last.correct;
      _lastGuessCount = s.guesses.length;
      if (lastWrong && !_shake.isAnimating) {
        _shake.forward(from: 0);
      }
    }

    return AnimatedBuilder(
      animation: _shake,
      builder: (context, child) {
        final t = _shake.value;
        final dx = t == 0
            ? 0.0
            : (t < 0.2 ? -6.0 : (t < 0.4 ? 6.0 : (t < 0.6 ? -4.0 : (t < 0.8 ? 4.0 : 0.0))));
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: Container(
        color: AppColors.onSurface,
        padding: const EdgeInsets.all(1),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 1,
            children: [
              for (final word in s.activeTiles)
                _Tile(
                  word: word,
                  selected: s.selected.contains(word),
                  onTap: () => ctrl.tap(word),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String word;
  final bool selected;
  final VoidCallback onTap;
  const _Tile({required this.word, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.inverseSurfaceBlack : AppColors.surfaceContainerHighest;
    final fg = selected ? AppColors.onPrimary : AppColors.onSurface;
    return Material(
      color: bg,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                word,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
