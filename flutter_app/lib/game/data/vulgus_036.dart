import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Body Politic II
const vulgus036 = Puzzle(
  id: 'VULGUS-036',
  categories: [
    PuzzleCategory(
      id: 'anatomy',
      label: 'Anatomical swears',
      etymology: 'Old English \'ærs\' — cognate with Dutch \'aars\', German \'Arsch\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['ARSE', 'BUM', 'BOLLOCKS', 'KNACKERS'],
    ),
    PuzzleCategory(
      id: 'body-euph',
      label: 'Body-part euphemisms',
      etymology: 'All four originate as slang for anatomy before shifting to "idiot."',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DORK', 'DIPSTICK', 'PILLOCK', 'SCHMUCK'],
    ),
    PuzzleCategory(
      id: 'head-comp',
      label: 'Head compounds',
      etymology: '1903 US baseball slang; popularised by Fred Merkle\'s \'boner\' play.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BONEHEAD', 'MEATHEAD', 'LUNKHEAD', 'KNUCKLEHEAD'],
    ),
    PuzzleCategory(
      id: 'hard-body',
      label: 'Strong body-origin words',
      etymology: 'All four trace to anatomy or bodily acts, now varying in sting.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['WANKER', 'BUGGER', 'BERK', 'CRAPPER'],
    ),
  ],
);
