import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Fifty Shades of Fool
const vulgus003 = Puzzle(
  id: 'VULGUS-003',
  categories: [
    PuzzleCategory(
      id: 'brit-easy',
      label: 'Classic words for a fool',
      etymology: 'From \'twit\' (to taunt); as \'fool\' from 1920s RAF slang.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['TWIT', 'NITWIT', 'KLUTZ', 'DWEEB'],
    ),
    PuzzleCategory(
      id: 'brit-scots',
      label: 'British and Scottish fools',
      etymology: 'Scots, late 20th C; origin uncertain — possibly from \'numps\' (fool).',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['NUMPTY', 'PLONKER', 'PILLOCK', 'BAMPOT'],
    ),
    PuzzleCategory(
      id: 'us-fools',
      label: 'American slang fools',
      etymology: '1960s US; originally slang for penis, now chiefly \'fool\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DORK', 'YAHOO', 'BONEHEAD', 'KNUCKLEHEAD'],
    ),
    PuzzleCategory(
      id: 'old-us',
      label: 'Old American slang fools',
      etymology: '19th C US; \'chuck\' = lump of wood.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CHUCKLEHEAD', 'DINGBAT', 'DIPSTICK', 'PALOOKA'],
    ),
  ],
);
