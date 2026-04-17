import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Body Politic
const vulgus012 = Puzzle(
  id: 'VULGUS-012',
  categories: [
    PuzzleCategory(
      id: 'anatomy',
      label: 'Words with anatomical roots',
      etymology: 'Old English \'beallucas\' (testicles); by the 1860s meant \'nonsense\'; Sex Pistols 1977.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'KNACKERS', 'BERK', 'PILLOCK'],
    ),
    PuzzleCategory(
      id: 'mild-body',
      label: 'Mild body-based words',
      etymology: 'Dates to 14th C Middle English — probably onomatopoeic.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BUM', 'DORK', 'DIPSTICK', 'NUMPTY'],
    ),
    PuzzleCategory(
      id: 'mil-body',
      label: 'Military slang',
      etymology: 'WWII US military acronym: Situation Normal, All F***ed Up.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNAFU', 'FUBAR', 'BOHICA', 'TARFU'],
    ),
    PuzzleCategory(
      id: 'polit',
      label: 'Political/social slang',
      etymology: 'From Yiddish \'shmok\' — penis; Yiddish origin keeps it strong in-community.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SCHMUCK', 'POGUE', 'YAHOO', 'BOGUS'],
    ),
  ],
);
