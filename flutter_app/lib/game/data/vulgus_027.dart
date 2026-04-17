import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Miscreants
const vulgus027 = Puzzle(
  id: 'VULGUS-027',
  categories: [
    PuzzleCategory(
      id: 'misc-y',
      label: 'Friendly miscreants',
      etymology: '1960s US campus slang; origin uncertain.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DOOFUS', 'WALLY', 'NIMROD', 'TURKEY'],
    ),
    PuzzleCategory(
      id: 'misc-b',
      label: 'Medium miscreants',
      etymology: 'Coined by Jonathan Swift (Gulliver\'s Travels, 1726); US sense: boorish person.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['YAHOO', 'JACKASS', 'DINGBAT', 'DIPSTICK'],
    ),
    PuzzleCategory(
      id: 'misc-r',
      label: 'Ruder miscreants',
      etymology: 'From Yiddish \'shmok\' — penis; Yiddish origin keeps it strong in-community.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['SCHMUCK', 'PUTZ', 'BERK', 'GOBSHITE'],
    ),
    PuzzleCategory(
      id: 'misc-k',
      label: 'Archaic miscreants',
      etymology: '19th C US — a shrewd, unprincipled politician.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNOLLYGOSTER', 'MOUNTEBANK', 'RAPSCALLION', 'VARLET'],
    ),
  ],
);
