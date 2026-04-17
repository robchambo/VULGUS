import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Parting Shot
const vulgus049 = Puzzle(
  id: 'VULGUS-049',
  categories: [
    PuzzleCategory(
      id: 'mild-one',
      label: 'Mild one-worders',
      etymology: 'The softest of the soft — safe for grandma, the office, and live television.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DARN', 'DRAT', 'RATS', 'SHUCKS'],
    ),
    PuzzleCategory(
      id: 'us-excl',
      label: 'American exclamation phrases',
      etymology: 'Multi-word American phrases — each a long detour around something shorter and stronger.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GEEZ LOUISE', 'FOR CRYIN\' OUT LOUD', 'SON OF A GUN', 'I\'LL BE'],
    ),
    PuzzleCategory(
      id: 'southern-send',
      label: 'Southern send-offs',
      etymology: 'Southern US: politeness, shock, and passive aggression in roughly equal measure.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BLESS YOUR HEART', 'HEAVENS TO BETSY', 'MERCY ME', 'TARNATION'],
    ),
    PuzzleCategory(
      id: 'midwest-mark',
      label: 'Midwest markers',
      etymology: 'Scandinavian-American "uff da," Minnesotan "don\'t cha know," and the universal Midwest "ope."',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['UFF DA', 'DON\'T CHA KNOW', 'CHEESE AND RICE', 'OPE'],
    ),
  ],
);
