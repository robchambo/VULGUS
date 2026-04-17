import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// American as Apple Pie
const vulgus007 = Puzzle(
  id: 'VULGUS-007',
  categories: [
    PuzzleCategory(
      id: 'us-mild',
      label: 'Mild American fools',
      etymology: 'From Yiddish \'klots\' — block of wood; clumsy person.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['KLUTZ', 'KOOK', 'GOOBER', 'DWEEB'],
    ),
    PuzzleCategory(
      id: 'us-strong',
      label: 'Stronger American words',
      etymology: 'From Yiddish \'shmok\' — penis; Yiddish origin keeps it strong in-community.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SCHMUCK', 'PUTZ', 'CRAP', 'JACKASS'],
    ),
    PuzzleCategory(
      id: 'head-words',
      label: 'Words ending in -HEAD',
      etymology: 'Mid-19th C US; \'lump\' + \'head\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['LUNKHEAD', 'MEATHEAD', 'BONEHEAD', 'CHUCKLEHEAD'],
    ),
    PuzzleCategory(
      id: 'wwii',
      label: 'WWII-era American slang',
      etymology: 'Modern US military slang for a non-combat soldier.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['POGUE', 'PALOOKA', 'CLUSTER', 'BOGUS'],
    ),
  ],
);
