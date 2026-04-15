import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'HOW TO PLAY',
            style: t.labelLarge?.copyWith(color: AppColors.secondary, letterSpacing: 3),
          ),
          const SizedBox(height: 4),
          Text(
            'RULES',
            style: t.displayLarge?.copyWith(fontSize: 64, height: 0.9, letterSpacing: -2),
          ),
          const SizedBox(height: 24),
          const _Rule('1', 'SIXTEEN WORDS.', 'Sort them into four secret categories of four.'),
          const _Rule('2', 'FOUR MISTAKES.', "Submit a wrong group and you lose a life. Four strikes and today's puzzle is done."),
          const _Rule('3', 'ETYMOLOGY.', 'Tap any tile to learn where the word comes from. The trick is in the history.'),
          const _Rule('4', 'ONE A DAY.', 'New puzzle every morning. Share your run, keep your streak, repeat.'),
        ],
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  final String n;
  final String title;
  final String body;
  const _Rule(this.n, this.title, this.body);

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            child: Text(
              n,
              style: t.displayMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: t.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(body, style: t.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
