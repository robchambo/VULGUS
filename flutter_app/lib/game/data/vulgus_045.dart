import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Mild Bunch
const vulgus045 = Puzzle(
  id: 'VULGUS-045',
  categories: [
    PuzzleCategory(
      id: 'short-mild',
      label: 'Short & mild',
      etymology: 'Contraction of \'od rot\' — mild minced oath.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DRAT', 'RATS', 'DANG', 'CRUD'],
    ),
    PuzzleCategory(
      id: 'exclam',
      label: 'Exclamations',
      etymology: 'Originally \'husks of no value\' → worthless → mild exclamation.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SHUCKS', 'PHOOEY', 'GOLLY', 'GOSH'],
    ),
    PuzzleCategory(
      id: 'brit-mild',
      label: 'British mild',
      etymology: 'Minced oath — euphemism for \'Christ\'.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['CRIKEY', 'BLIMEY', 'CRIPES', 'EGAD'],
    ),
    PuzzleCategory(
      id: 'jesus-mild',
      label: 'Jesus-derived mild',
      etymology: 'Euphemism for \'Jesus Christ\'; 1920s US.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['JEEPERS', 'GEE', 'JIMINY', 'BEJESUS'],
    ),
  ],
);
