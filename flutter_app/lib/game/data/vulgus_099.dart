import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Last Orders
const vulgus099 = Puzzle(
  id: 'VULGUS-099',
  categories: [
    PuzzleCategory(
      id: 'last-best',
      label: 'All-time best insults',
      etymology: 'The Mount Rushmore of English-language fool-words — British, Scottish, Irish, and Australian.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['MUPPET', 'NUMPTY', 'EEJIT', 'DRONGO'],
    ),
    PuzzleCategory(
      id: 'last-strong',
      label: 'All-time strongest',
      etymology: 'The heavy artillery — British swearing at its most concentrated.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['WANKER', 'GOBSHITE', 'BOLLOCKS', 'BLOODY'],
    ),
    PuzzleCategory(
      id: 'last-arch',
      label: 'All-time best archaic',
      etymology: 'The words that deserve resurrection — God\'s wounds, a fat slob, a 19th C conman, and crooked.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['ZOUNDS', 'FUSTILUGS', 'SNOLLYGOSTER', 'CATTYWAMPUS'],
    ),
    PuzzleCategory(
      id: 'last-mild',
      label: 'All-time mildest',
      etymology: 'So mild they barely register — but each one is technically a minced oath.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['DRAT', 'SHUCKS', 'GEE', 'CRUMBS'],
    ),
  ],
);
