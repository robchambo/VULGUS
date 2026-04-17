import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Pan-American Slang
const vulgus028 = Puzzle(
  id: 'VULGUS-028',
  categories: [
    PuzzleCategory(
      id: 'pan-mild',
      label: 'Mild pan-American slang',
      etymology: 'From Gullah for \'peanut\'; as \'fool\' chiefly US Southern 20th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['GOOBER', 'KLUTZ', 'KOOK', 'DWEEB'],
    ),
    PuzzleCategory(
      id: 'pan-med',
      label: 'Medium American slang',
      etymology: 'From Yiddish \'shmok\' — penis; Yiddish origin keeps it strong in-community.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SCHMUCK', 'PUTZ', 'BONEHEAD', 'MEATHEAD'],
    ),
    PuzzleCategory(
      id: 'pan-mod',
      label: 'Modern American slang',
      etymology: '1790s US counterfeit coins; \'fake, bad\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BOGUS', 'SALTY', 'BUSTED', 'SHOOK'],
    ),
    PuzzleCategory(
      id: 'pan-mil',
      label: 'Military-origin slang',
      etymology: 'WWII US military acronym: Situation Normal, All F***ed Up.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNAFU', 'FUBAR', 'BOHICA', 'TARFU'],
    ),
  ],
);
