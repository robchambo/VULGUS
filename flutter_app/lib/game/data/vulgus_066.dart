import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Minced Oaths II
const vulgus066 = Puzzle(
  id: 'VULGUS-066',
  categories: [
    PuzzleCategory(
      id: 'minced-god',
      label: 'Minced "God"',
      etymology: 'Euphemisms for invoking the Almighty — each a syllable or two away from blasphemy.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['GOLLY', 'GOSH', 'GOOD GRIEF', 'CRIPES'],
    ),
    PuzzleCategory(
      id: 'minced-damn',
      label: 'Minced "damn"',
      etymology: 'The d-word family of avoidances — all circling "damn" without quite landing on it.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DANG', 'DARN', 'DRAT', 'DAGNABBIT'],
    ),
    PuzzleCategory(
      id: 'minced-hell',
      label: 'Minced "hell"',
      etymology: 'Hellish euphemisms — heck for hell, hellfire direct, and two that smuggle "damnation" in disguise.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['HECK', 'HELLFIRE', 'TARNATION', 'CRIMINY'],
    ),
    PuzzleCategory(
      id: 'minced-jesus2',
      label: 'Minced "Jesus" (round 2)',
      etymology: 'From short clips to full phonetic rewrites — all ducking the second commandment.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['JEEZ', 'JIMINY', 'JEEPERS', 'CHEESE AND RICE'],
    ),
  ],
);
