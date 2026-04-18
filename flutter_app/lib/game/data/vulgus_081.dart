import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Bard's Best
const vulgus081 = Puzzle(
  id: 'VULGUS-081',
  categories: [
    PuzzleCategory(
      id: 'bard-insult',
      label: 'Shakespearean insults',
      etymology: 'The Bard\'s choicest insults — an ape-man, a fat slob, a lecher, and a base wretch.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['JACKANAPES', 'FUSTILUGS', 'LEWDSTER', 'CULLION'],
    ),
    PuzzleCategory(
      id: 'bard-animal',
      label: 'Shakespearean animals',
      etymology: 'Shakespeare\'s bestiary of contempt — a hedgehog, a gullible fish, a greedy kite, and a venomous snake.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['HEDGE-PIG', 'GUDGEON', 'PUTTOCK', 'VIPER'],
    ),
    PuzzleCategory(
      id: 'bard-adj',
      label: 'Shakespearean modifiers',
      etymology: 'Adjectives and nouns of Shakespearean scorn — petty, diseased, clumsy, and moon-born.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['PRIBBLING', 'CANKER', 'LOUT', 'MOONCALF'],
    ),
    PuzzleCategory(
      id: 'bard-survive',
      label: 'Shakespeare\'s survivors',
      etymology: 'Shakespearean words that survived into modern English — we still call people these today.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['KNAVE', 'ROGUE', 'SCOUNDREL', 'VARLET'],
    ),
  ],
);
