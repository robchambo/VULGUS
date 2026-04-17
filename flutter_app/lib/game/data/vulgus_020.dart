import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Intensifiers
const vulgus020 = Puzzle(
  id: 'VULGUS-020',
  categories: [
    PuzzleCategory(
      id: 'brit-int',
      label: 'British intensifiers',
      etymology: 'From Medieval Latin \'Bulgarus\' — referring to heretical Bulgarian sect; meaning shifted through centuries.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BUGGER', 'BLOODY', 'DAMN', 'HELLFIRE'],
    ),
    PuzzleCategory(
      id: 'us-int',
      label: 'American intensifiers',
      etymology: 'New England intensifier (\'wicked good\'); regional since 19th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['WICKED', 'HECK', 'DANG', 'CRUD'],
    ),
    PuzzleCategory(
      id: 'slang-int',
      label: 'Slang intensifiers',
      etymology: '1790s US counterfeit coins; \'fake, bad\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BOGUS', 'WACK', 'JANKY', 'SALTY'],
    ),
    PuzzleCategory(
      id: 'archaic-int',
      label: 'Archaic intensifiers',
      etymology: '18th C US; blend of \'eternal\' and \'damnation\'.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['TARNATION', 'CONSARN', 'ZOUNDS', 'EGAD'],
    ),
  ],
);
