import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Trash Talk
const vulgus047 = Puzzle(
  id: 'VULGUS-047',
  categories: [
    PuzzleCategory(
      id: 'us-nerd',
      label: 'US nerd insults',
      etymology: '1950s US surfer/beatnik slang; \'crazy person\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['KOOK', 'NIMROD', 'DWEEB', 'DORK'],
    ),
    PuzzleCategory(
      id: 'us-fool2',
      label: 'US fools',
      etymology: '1960s US campus slang; origin uncertain.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DOOFUS', 'DINGBAT', 'DIPSTICK', 'PALOOKA'],
    ),
    PuzzleCategory(
      id: 'us-animal',
      label: 'US animal insults',
      etymology: '1950s US; a flop or a fool.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['TURKEY', 'JACKASS', 'PIG', 'COW'],
    ),
    PuzzleCategory(
      id: 'us-dismiss',
      label: 'US dismissals',
      etymology: '1790s US counterfeit coins; \'fake, bad\'.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BOGUS', 'POGUE', 'SAD SACK', 'CLUSTER'],
    ),
  ],
);
