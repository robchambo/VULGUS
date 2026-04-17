import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Exclamation!
const vulgus017 = Puzzle(
  id: 'VULGUS-017',
  categories: [
    PuzzleCategory(
      id: 'excl-easy',
      label: 'Everyday exclamations',
      etymology: 'Originally \'husks of no value\' → worthless → mild exclamation.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SHUCKS', 'PHOOEY', 'RATS', 'DRAT'],
    ),
    PuzzleCategory(
      id: 'excl-brit',
      label: 'British exclamations',
      etymology: 'Contraction of \'God blind me!\' — minced oath.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BLIMEY', 'CRIKEY', 'CRUMBS', 'BUM'],
    ),
    PuzzleCategory(
      id: 'excl-relig',
      label: 'Religious exclamations',
      etymology: 'Clipped form of \'Jesus\'; late 19th C US.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['GEE', 'GOSH', 'GOLLY', 'JEEZ'],
    ),
    PuzzleCategory(
      id: 'excl-arch',
      label: 'Archaic exclamations',
      etymology: 'Contraction of \'God\'s wounds\' — 16th C oath.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['ZOUNDS', 'EGAD', 'GADZOOKS', 'TARNATION'],
    ),
  ],
);
