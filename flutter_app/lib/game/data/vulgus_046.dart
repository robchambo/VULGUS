import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Pub Chatter
const vulgus046 = Puzzle(
  id: 'VULGUS-046',
  categories: [
    PuzzleCategory(
      id: 'pub-swear',
      label: 'Pub swears',
      etymology: 'From Medieval Latin \'Bulgarus\' — referring to heretical Bulgarian sect; meaning shifted through centuries.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BUGGER', 'BLOODY', 'BLIMEY', 'CRIKEY'],
    ),
    PuzzleCategory(
      id: 'pub-body',
      label: 'Pub anatomy',
      etymology: 'Old English \'ærs\' — cognate with Dutch \'aars\', German \'Arsch\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['ARSE', 'CRAPPER', 'KNACKERS', 'BOLLOCKS'],
    ),
    PuzzleCategory(
      id: 'pub-idiot',
      label: 'Pub words for idiot',
      etymology: 'Scots, late 20th C; origin uncertain — possibly from \'numps\' (fool).',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['NUMPTY', 'WALLY', 'PLONKER', 'PILLOCK'],
    ),
    PuzzleCategory(
      id: 'pub-strong',
      label: 'Pub strong words',
      etymology: 'Strong insult in UK/AU; anatomical origin. Medium in AU, stronger in UK.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['WANKER', 'GOBSHITE', 'BOGAN', 'BERK'],
    ),
  ],
);
