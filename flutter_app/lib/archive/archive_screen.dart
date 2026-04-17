import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game/daily_puzzle_service.dart';
import '../game/data/puzzle_library.dart';
import '../game/stats_repository.dart';
import '../theme/app_colors.dart';

final _epoch = DateTime(2026, 1, 1);

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleNum = ref.watch(puzzleNumberProvider);
    final playedAsync = ref.watch(playedDatesProvider);
    final t = Theme.of(context).textTheme;

    return playedAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (playedDates) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ARCHIVE',
                    style: t.displayLarge?.copyWith(
                      fontSize: 56,
                      height: 0.9,
                      letterSpacing: -2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'EVERY PUZZLE, EVERY DAY',
                    style: t.labelLarge?.copyWith(
                      color: AppColors.secondary,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // List
            Expanded(
              child: ListView.builder(
                itemCount: puzzleNum,
                itemBuilder: (context, index) {
                  // Reverse chronological: newest first
                  final dayNumber = puzzleNum - index;
                  final puzzleIndex = dayNumber - 1;
                  final puzzleDate =
                      _epoch.add(Duration(days: dayNumber - 1));
                  final dateKey = _formatDateKey(puzzleDate);
                  final isPlayed = playedDates.contains(dateKey);

                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final sevenDaysAgo =
                      today.subtract(const Duration(days: 7));
                  final puzzleDateOnly = DateTime(
                      puzzleDate.year, puzzleDate.month, puzzleDate.day,);
                  final isFree = !puzzleDateOnly.isBefore(sevenDaysAgo);
                  final isLocked = !isFree;
                  final isToday = puzzleDateOnly == today;

                  // Get category labels
                  final puzzle = puzzleLibrary[
                      puzzleIndex % puzzleLibrary.length];
                  final categoryHint = puzzle.categories.length >= 2
                      ? '${puzzle.categories[0].label} / ${puzzle.categories[1].label}'
                      : puzzle.categories.isNotEmpty
                          ? puzzle.categories[0].label
                          : '';

                  return GestureDetector(
                    onTap: () => _onTap(context, isToday, isLocked),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.onSurface,
                            width: 2,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Puzzle number
                              Text(
                                dayNumber.toString().padLeft(3, '0'),
                                style: t.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                ),
                              ),
                              const Spacer(),
                              // Date
                              Text(
                                _formatDisplayDate(puzzleDate),
                                style: t.labelLarge?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const Spacer(),
                              // Status icon
                              if (isPlayed)
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF4CAF50),
                                  size: 24,
                                )
                              else if (isLocked)
                                const Icon(
                                  Icons.lock,
                                  color: AppColors.outline,
                                  size: 24,
                                )
                              else
                                const SizedBox(width: 24),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            categoryHint,
                            style: t.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _onTap(BuildContext context, bool isToday, bool isLocked) {
    if (isLocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Puzzle archive unlocks with VULGUS+'),
        ),
      );
    } else if (isToday) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Navigate to Play tab to play today\'s puzzle'),
        ),
      );
    }
  }

  String _formatDateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static const _months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
  ];

  String _formatDisplayDate(DateTime d) =>
      '${d.day} ${_months[d.month - 1]} ${d.year}';
}
