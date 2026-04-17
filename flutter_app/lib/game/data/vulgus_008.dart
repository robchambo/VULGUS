import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Celtic Fringe
const vulgus008 = Puzzle(
  id: 'VULGUS-008',
  categories: [
    PuzzleCategory(
      id: 'irish',
      label: 'Irish English favourites',
      etymology: 'Hiberno-English rendering of \'idiot\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['EEJIT', 'GOBSHITE', 'BAMPOT', 'FECKIN'],
    ),
    PuzzleCategory(
      id: 'aussie',
      label: 'Australian slang',
      etymology: 'From an Australian racehorse (1920s) that never won; then bird → fool.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DRONGO', 'GALAH', 'BOGAN', 'WANKER'],
    ),
    PuzzleCategory(
      id: 'brit-y',
      label: 'Easy British words',
      etymology: 'Dates to 14th C Middle English — probably onomatopoeic.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BUM', 'BLIMEY', 'RATS', 'DRAT'],
    ),
    PuzzleCategory(
      id: 'uk-med',
      label: 'Medium British words',
      etymology: 'From Medieval Latin \'Bulgarus\' — referring to heretical Bulgarian sect; meaning shifted through centuries.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BUGGER', 'BLOODY', 'PILLOCK', 'NUMPTY'],
    ),
  ],
);
