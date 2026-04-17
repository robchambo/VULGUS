import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Name That Fool
const vulgus042 = Puzzle(
  id: 'VULGUS-042',
  categories: [
    PuzzleCategory(
      id: 'heads',
      label: 'The -HEAD crew',
      etymology: '1903 US baseball slang; popularised by Fred Merkle\'s \'boner\' play.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BONEHEAD', 'MEATHEAD', 'CHUCKLEHEAD', 'KNUCKLEHEAD'],
    ),
    PuzzleCategory(
      id: 'nerdy',
      label: 'Nerdy fools',
      etymology: '1960s US; originally slang for penis, now chiefly \'fool\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DORK', 'DWEEB', 'GOOBER', 'KOOK'],
    ),
    PuzzleCategory(
      id: 'us-crossover',
      label: 'American fools',
      etymology: 'Late 19th C US; popularised by Archie Bunker (\'All in the Family\').',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['DINGBAT', 'DIPSTICK', 'DOOFUS', 'NUMPTY'],
    ),
    PuzzleCategory(
      id: 'brit-idiot',
      label: 'British "idiot" words',
      etymology: '1920s, from \'nit\' (nothing) + wit.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['NITWIT', 'TWIT', 'WALLY', 'PLONKER'],
    ),
  ],
);
