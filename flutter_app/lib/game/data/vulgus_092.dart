import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Cross-Cultural Fools
const vulgus092 = Puzzle(
  id: 'VULGUS-092',
  categories: [
    PuzzleCategory(
      id: 'cc-brit2',
      label: 'British fools',
      etymology: 'The British fool hall of fame — each affectionate enough to use on friends.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['WALLY', 'MUPPET', 'PLONKER', 'NITWIT'],
    ),
    PuzzleCategory(
      id: 'cc-us2',
      label: 'American fools',
      etymology: 'American fool vocabulary — the clumsy, the nutty, the nerdy, and the weedy.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DOOFUS', 'KLUTZ', 'GOOBER', 'DWEEB'],
    ),
    PuzzleCategory(
      id: 'cc-celtic3',
      label: 'Celtic fools',
      etymology: 'Celtic fool vocabulary — the Irish idiot, the Scottish useless, the crazy, and the cuckoo.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['EEJIT', 'NUMPTY', 'BAMPOT', 'GOWK'],
    ),
    PuzzleCategory(
      id: 'cc-oz2',
      label: 'Australian fools',
      etymology: 'Australian fool vocabulary — a cockatoo, a slow horse, an herb, and a clumsy oaf.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GALAH', 'DRONGO', 'DILL', 'GALOOT'],
    ),
  ],
);
