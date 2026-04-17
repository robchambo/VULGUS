import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Idiots International
const vulgus033 = Puzzle(
  id: 'VULGUS-033',
  categories: [
    PuzzleCategory(
      id: 'brit-fool',
      label: 'British fools',
      etymology: '1960s UK slang; disputed origin — possibly from \'Walter\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['WALLY', 'PILLOCK', 'PLONKER', 'MUPPET'],
    ),
    PuzzleCategory(
      id: 'us-fool',
      label: 'American fools',
      etymology: '1960s US campus slang; origin uncertain.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DOOFUS', 'DINGBAT', 'DIPSTICK', 'KLUTZ'],
    ),
    PuzzleCategory(
      id: 'aus-fool',
      label: 'Australian fools',
      etymology: 'Australian English, often drawn from native bird names or anglicised imports.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['DRONGO', 'GALAH', 'BOGAN', 'PALOOKA'],
    ),
    PuzzleCategory(
      id: 'celtic-fool',
      label: 'Celtic fools',
      etymology: 'Hiberno-English rendering of \'idiot\'.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['EEJIT', 'BAMPOT', 'NUMPTY', 'GOBSHITE'],
    ),
  ],
);
