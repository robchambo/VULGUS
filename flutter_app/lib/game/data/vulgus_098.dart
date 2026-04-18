import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Historical Layers
const vulgus098 = Puzzle(
  id: 'VULGUS-098',
  categories: [
    PuzzleCategory(
      id: 'hist-medieval',
      label: 'Medieval layer',
      etymology: 'The oldest layer of English insults — servants, peasants, and scoundrels.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['KNAVE', 'CHURL', 'ROGUE', 'VARLET'],
    ),
    PuzzleCategory(
      id: 'hist-victorian',
      label: 'Victorian layer',
      etymology: 'The Victorian gentleman\'s insult vocabulary — each implying a failure of breeding or character.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BOUNDER', 'ROTTER', 'CAD', 'COVE'],
    ),
    PuzzleCategory(
      id: 'hist-modern',
      label: 'Modern layer',
      etymology: 'Late 20th century British additions — TV puppets, wine bottles, and Scottish uselessness.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['MUPPET', 'PLONKER', 'WALLY', 'NUMPTY'],
    ),
    PuzzleCategory(
      id: 'hist-future',
      label: 'Internet layer',
      etymology: 'The newest layer — 21st century slang for broken, bitter, shocked, and overreacting.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['JANKY', 'SALTY', 'SHOOK', 'TRIPPIN'],
    ),
  ],
);
