import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

const vulgus005 = Puzzle(
  id: 'VULGUS-005',
  categories: [
    PuzzleCategory(
      id: 'bonkers',
      label: 'British Words for Crazy',
      etymology: '',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DAFT', 'BARMY', 'CRACKERS', 'BONKERS'],
    ),
    PuzzleCategory(
      id: 'wolf',
      label: 'Ways to Eat Greedily',
      etymology: '',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GORGE', 'WOLF', 'GUZZLE', 'STUFF'],
    ),
    PuzzleCategory(
      id: 'legless',
      label: 'Very Drunk (British)',
      etymology: '',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BLOTTO', 'LEGLESS', 'TROLLEYED', 'BLADDERED'],
    ),
    PuzzleCategory(
      id: 'coward',
      label: 'Archaic Words for a Coward',
      etymology: '',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CAITIFF', 'POLTROON', 'CRAVEN', 'DASTARD'],
    ),
  ],
);
