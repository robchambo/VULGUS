import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../data/etymologies.dart';
import '../mini_puzzle_controller.dart';

class MiniEtymologyStrip extends ConsumerWidget {
  const MiniEtymologyStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    final word = s.lastTapped;
    return Container(
      constraints: const BoxConstraints(minHeight: 96),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: word == null
          ? Center(
              child: Text(
                'TAP A WORD TO SEE WHERE IT COMES FROM.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                      letterSpacing: 2,
                    ),
              ),
            )
          : _Filled(word: word, ety: etymologies[word.toUpperCase()]),
    );
  }
}

class _Filled extends StatelessWidget {
  final String word;
  final Etymology? ety;
  const _Filled({required this.word, required this.ety});

  @override
  Widget build(BuildContext context) {
    final meta = ety?.meta ?? '';
    final note = ety?.note ?? '(etymology pending)';
    return TweenAnimationBuilder<double>(
      key: ValueKey(word),
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 120),
      builder: (_, t, __) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, (1 - t) * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      word.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                    ),
                  ),
                  if (meta.isNotEmpty)
                    Text(
                      meta.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 10,
                            letterSpacing: 2,
                          ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(note, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
