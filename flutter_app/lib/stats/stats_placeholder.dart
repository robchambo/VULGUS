import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game/models/game_stats.dart';
import '../game/stats_repository.dart';
import '../theme/app_colors.dart';

class StatsPlaceholder extends ConsumerWidget {
  const StatsPlaceholder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);
    final todayAsync = ref.watch(todayResultProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(statsProvider);
        ref.invalidate(todayResultProvider);
        await ref.read(statsProvider.future);
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          _Header(),
          const SizedBox(height: 20),
          statsAsync.when(
            data: (stats) => _StatsBody(
              stats: stats,
              today: todayAsync.asData?.value,
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const _ErrorState(),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'YOUR',
          style: t.labelLarge?.copyWith(
            color: AppColors.secondary,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'STATS',
          style: t.displayLarge?.copyWith(
            fontSize: 56,
            height: 0.9,
            letterSpacing: -2,
          ),
        ),
      ],
    );
  }
}

class _StatsBody extends StatelessWidget {
  final GameStats stats;
  final TodayResult? today;
  const _StatsBody({required this.stats, required this.today});

  @override
  Widget build(BuildContext context) {
    if (stats.gamesPlayed == 0) {
      return const _EmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _BigStatsGrid(stats: stats),
        const SizedBox(height: 20),
        if (today != null) _TodayCard(result: today!),
        if (today != null) const SizedBox(height: 20),
        _NextPuzzleCountdown(),
      ],
    );
  }
}

class _BigStatsGrid extends StatelessWidget {
  final GameStats stats;
  const _BigStatsGrid({required this.stats});

  @override
  Widget build(BuildContext context) {
    final pct = (stats.winRate * 100).round();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _BigStatTile(
                label: 'CURRENT STREAK',
                value: '${stats.currentStreak}',
                accent: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _BigStatTile(
                label: 'BEST STREAK',
                value: '${stats.maxStreak}',
                accent: AppColors.secondaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _BigStatTile(
                label: 'PLAYED',
                value: '${stats.gamesPlayed}',
                accent: AppColors.tertiary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _BigStatTile(
                label: 'WIN %',
                value: '$pct',
                accent: AppColors.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _WonRow(won: stats.gamesWon, played: stats.gamesPlayed),
      ],
    );
  }
}

class _BigStatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;
  const _BigStatTile({
    required this.label,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 28, height: 4, color: accent),
          const SizedBox(height: 10),
          Text(
            value,
            style: t.displayMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              height: 0.95,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: t.labelSmall?.copyWith(letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}

class _WonRow extends StatelessWidget {
  final int won;
  final int played;
  const _WonRow({required this.won, required this.played});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final ratio = played == 0 ? 0.0 : won / played;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'WINS',
                style: t.labelSmall?.copyWith(letterSpacing: 2),
              ),
              Text(
                '$won / $played',
                style: t.labelLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, c) {
              final filled = c.maxWidth * ratio.clamp(0.0, 1.0);
              return SizedBox(
                height: 10,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(color: AppColors.surfaceContainerHigh),
                    SizedBox(
                      width: filled,
                      child: Container(color: AppColors.primary),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  final TodayResult result;
  const _TodayCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final summary = result.won
        ? 'Done in ${result.guesses} ${result.guesses == 1 ? 'guess' : 'guesses'}, ${result.mistakes} ${result.mistakes == 1 ? 'mistake' : 'mistakes'}.'
        : 'Ran out of lives after ${result.guesses} guesses.';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'TODAY',
            style: t.labelLarge?.copyWith(
              color: AppColors.secondary,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            result.won ? 'SORTED.' : 'NO CIGAR.',
            style: t.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              height: 0.95,
            ),
          ),
          const SizedBox(height: 8),
          Text(summary, style: t.bodyMedium),
          if (result.shareGrid.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.surfaceContainerHigh,
              child: Text(
                result.shareGrid,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 20,
                  height: 1.3,
                ),
              ),
            ),
          ],
          if (result.shareText.isNotEmpty) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Clipboard.setData(ClipboardData(text: result.shareText)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tertiary,
                  foregroundColor: AppColors.onTertiary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: AppColors.onSurface, width: 2),
                  ),
                  minimumSize: const Size.fromHeight(44),
                  elevation: 0,
                ),
                child: const Text('COPY SHARE'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NO GAMES YET',
            style: t.labelLarge?.copyWith(
              color: AppColors.secondary,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Play today\'s puzzle to start a streak.',
            style: t.bodyLarge,
          ),
          const SizedBox(height: 16),
          _NextPuzzleCountdown(),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Text(
        'Could not load stats. Pull to retry.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
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
    final t = Theme.of(context).textTheme;
    final h = _remaining.inHours.toString().padLeft(2, '0');
    final m = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final s = (_remaining.inSeconds % 60).toString().padLeft(2, '0');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NEXT PUZZLE IN',
          style: t.labelSmall?.copyWith(letterSpacing: 2),
        ),
        const SizedBox(height: 4),
        Text(
          '$h:$m:$s',
          style: t.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            fontFeatures: [const FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
