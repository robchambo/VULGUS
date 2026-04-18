import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Softer Side
const vulgus091 = Puzzle(
  id: 'VULGUS-091',
  categories: [
    PuzzleCategory(
      id: 'soft-brit',
      label: 'Soft British',
      etymology: 'British words safe for daytime television — surprise and mild intensification.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['CRIKEY', 'CRUMBS', 'BLOOMING', 'RUDDY'],
    ),
    PuzzleCategory(
      id: 'soft-us2',
      label: 'Soft American',
      etymology: 'American words safe for grandma — gentle surprise and mild disappointment.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SHUCKS', 'PHOOEY', 'GOSH', 'DARN'],
    ),
    PuzzleCategory(
      id: 'soft-phrase',
      label: 'Soft phrases',
      etymology: 'Full phrases that sound like they\'re about to swear but never do.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['GOOD GRIEF', 'HOLY MOLY', 'MERCY ME', 'FOR PETE\'S SAKE'],
    ),
    PuzzleCategory(
      id: 'soft-minced',
      label: 'Softest minced oaths',
      etymology: 'The absolute softest — each barely a whisper of the word it\'s standing in for.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GEE', 'HECK', 'RATS', 'SHOOT'],
    ),
  ],
);
