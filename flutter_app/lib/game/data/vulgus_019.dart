import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Keeping It Clean
const vulgus019 = Puzzle(
  id: 'VULGUS-019',
  categories: [
    PuzzleCategory(
      id: 'g-rated',
      label: 'G-rated stand-ins',
      etymology: 'Stand-in for a stronger s-word; established 20th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SUGAR', 'FUDGE', 'SHOOT', 'DARN'],
    ),
    PuzzleCategory(
      id: 'workplace',
      label: 'Workplace-safe words',
      etymology: 'Minced form of \'hell\'; late 19th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['HECK', 'DANG', 'CRUD', 'RECKON'],
    ),
    PuzzleCategory(
      id: 'mild-us',
      label: 'Mild US expressions',
      etymology: 'Euphemism for \'Jesus Christ\'; 1920s US.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['JEEPERS', 'SAKES', 'JIMINY', 'DAGNABBIT'],
    ),
    PuzzleCategory(
      id: 'soft-brit',
      label: 'Mild British expressions',
      etymology: 'Originally \'husks of no value\' → worthless → mild exclamation.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SHUCKS', 'PHOOEY', 'RATS', 'CRUMBS'],
    ),
  ],
);
