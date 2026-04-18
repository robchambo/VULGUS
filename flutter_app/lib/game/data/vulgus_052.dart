import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Shakespeare's Insult Kit
const vulgus052 = Puzzle(
  id: 'VULGUS-052',
  categories: [
    PuzzleCategory(
      id: 'shakes-animal',
      label: 'Shakespeare\'s animal insults',
      etymology: 'The Bard loved animal metaphors for contempt — hedgehogs, gullible fish, rabbit tails, and greedy kites.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['HEDGE-PIG', 'GUDGEON', 'SCUT', 'PUTTOCK'],
    ),
    PuzzleCategory(
      id: 'shakes-fool',
      label: 'Shakespeare\'s fools',
      etymology: 'Shakespearean insults for the dim and the coarse — thick-headed, fat, villainous, and moon-born.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CLOTPOLE', 'FUSTILUGS', 'CULLION', 'MOONCALF'],
    ),
    PuzzleCategory(
      id: 'shakes-rogue',
      label: 'Shakespeare\'s rogues',
      etymology: 'Shakespeare\'s words for scoundrels, lechers, harlots, and venomous snakes.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['JACKANAPES', 'LEWDSTER', 'STRUMPET', 'VIPER'],
    ),
    PuzzleCategory(
      id: 'shakes-adj',
      label: 'Shakespeare\'s modifiers of contempt',
      etymology: 'Adjectives and epithets from the plays — petty, diseased, clumsy, and cowardly.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['PRIBBLING', 'CANKER', 'LOUT', 'POLTROON'],
    ),
  ],
);
