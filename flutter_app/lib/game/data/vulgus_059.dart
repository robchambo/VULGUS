import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Stage Fright
const vulgus059 = Puzzle(
  id: 'VULGUS-059',
  categories: [
    PuzzleCategory(
      id: 'theatre-perf',
      label: 'Theatrical performers',
      etymology: 'Theatre insults for the over-actor — hamming it up, being precious, pulling faces, and eating the set.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['HAM', 'LUVVIE', 'MUGGER', 'SCENERY CHEWER'],
    ),
    PuzzleCategory(
      id: 'theatre-fail',
      label: 'Theatrical failures',
      etymology: 'Things that go wrong on stage — a bomb, forgetting lines, lazy work, and stealing focus.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['FLOP', 'CORPSE', 'HACK', 'UPSTAGE'],
    ),
    PuzzleCategory(
      id: 'theatre-cross',
      label: 'Theatrical crossovers',
      etymology: 'Words equally at home in Shakespeare and in theatrical insult — cowards, ape-men, rascals, and rogues.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['POLTROON', 'JACKANAPES', 'RAPSCALLION', 'KNAVE'],
    ),
    PuzzleCategory(
      id: 'theatre-hidden',
      label: 'Secretly theatrical',
      etymology: 'Cockney rhyming slang meets theatre — bimbo from Italian for baby, Hampton Wick, raspberry tart, Brahms and Liszt.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BIMBO', 'HAMPTON', 'RASPBERRY', 'BRAHMS'],
    ),
  ],
);
