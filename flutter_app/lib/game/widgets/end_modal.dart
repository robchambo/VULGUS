import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';
import '../models/game_stats.dart';
import '../share_text.dart';
import '../stats_repository.dart';

class EndModal extends ConsumerWidget {
  const EndModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    if (!s.isOver) return const SizedBox.shrink();

    final share = buildShareText(
      puzzleId: s.puzzle.id,
      guesses: s.guesses,
      solved: s.solved.length.clamp(0, s.puzzle.categories.length),
      mistakes: s.mistakes,
      puzzle: s.puzzle,
    );
    final grid = buildShareGrid(s.guesses, s.puzzle);
    final title = s.isWon ? 'SORTED THE SWEARY.' : 'TRY TOMORROW.';
    final body = s.isWon
        ? 'Done in ${s.guesses.length} ${s.guesses.length == 1 ? 'guess' : 'guesses'}, ${s.mistakes} ${s.mistakes == 1 ? 'mistake' : 'mistakes'}.'
        : 'Ran out of lives after ${s.guesses.length} guesses.';

    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 440),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            border: Border.all(color: AppColors.onSurface, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RESULT',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.secondary,
                      letterSpacing: 3,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                      height: 0.95,
                    ),
              ),
              const SizedBox(height: 12),
              Text(body, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, _) {
                  final statsAsync = ref.watch(statsProvider);
                  return statsAsync.when(
                    data: (stats) => _StatsRow(stats: stats),
                    loading: () => const SizedBox(height: 44),
                    error: (_, __) => const SizedBox(height: 44),
                  );
                },
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: AppColors.surfaceContainerHigh,
                child: Text(
                  grid,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 20,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _NextPuzzleCountdown(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Clipboard.setData(ClipboardData(text: share)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tertiary,
                    foregroundColor: AppColors.onTertiary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: AppColors.onSurface, width: 2),
                    ),
                    minimumSize: const Size.fromHeight(48),
                    elevation: 0,
                  ),
                  child: const Text('COPY SHARE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final GameStats stats;
  const _StatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    final pct = (stats.winRate * 100).round();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.surfaceContainerHighest),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Stat(label: 'STREAK', value: '${stats.currentStreak}'),
          _Stat(label: 'PLAYED', value: '${stats.gamesPlayed}'),
          _Stat(label: 'WIN %', value: '$pct'),
          _Stat(label: 'BEST', value: '${stats.maxStreak}'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _NextPuzzleCountdown extends StatefulWidget {
  @override
  State<_NextPuzzleCountdown> createState() => _NextPuzzleCountdownState();
}

class _NextPuzzleCountdownState extends State<_NextPuzzleCountdown> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _update();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(_update);
    });
  }

  void _update() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    _remaining = midnight.difference(now);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = _remaining.inHours.toString().padLeft(2, '0');
    final m = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final s = (_remaining.inSeconds % 60).toString().padLeft(2, '0');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NEXT PUZZLE IN',
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(letterSpacing: 2),
        ),
        const SizedBox(height: 4),
        Text(
          '$h:$m:$s',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontFeatures: [const FontFeature.tabularFigures()],
              ),
        ),
      ],
    );
  }
}
