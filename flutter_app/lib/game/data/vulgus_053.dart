import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Sailor Talk
const vulgus053 = Puzzle(
  id: 'VULGUS-053',
  categories: [
    PuzzleCategory(
      id: 'naut-insult',
      label: 'Nautical insults',
      etymology: 'Pirate-era insults for the useless, the inexperienced, and the generally unwashed.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BILGE RAT', 'LANDLUBBER', 'SWAB', 'SCURVY'],
    ),
    PuzzleCategory(
      id: 'naut-rogue',
      label: 'Nautical rogues',
      etymology: 'Words for sea-going scoundrels — from Caribbean meat-smokers to wretched deckhands.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BUCCANEER', 'FREEBOOTER', 'SCALLYWAG', 'WRETCH'],
    ),
    PuzzleCategory(
      id: 'naut-action',
      label: 'Nautical punishments',
      etymology: 'Things done to or found on the worst sailors — dragged under the keel, stuck in filth, or sunk.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['KEELHAUL', 'BILGE', 'BARNACLE', 'SCUPPER'],
    ),
    PuzzleCategory(
      id: 'naut-cross',
      label: 'Also nautical (surprisingly)',
      etymology: 'Words with unexpected naval or dockside connections — cheap wine, filth, hot air, and stomach lining.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['PLONK', 'DRECK', 'GUFF', 'TRIPE'],
    ),
  ],
);
