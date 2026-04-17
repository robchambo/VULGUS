import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Words for Rubbish
const vulgus026 = Puzzle(
  id: 'VULGUS-026',
  categories: [
    PuzzleCategory(
      id: 'rub-y',
      label: 'G-rated rubbish words',
      etymology: 'From violin bows being flimsy and trivial; 17th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['FIDDLESTICKS', 'HOOEY', 'HOGWASH', 'RATS'],
    ),
    PuzzleCategory(
      id: 'rub-v',
      label: 'Victorian rubbish',
      etymology: 'Mid-18th C; made famous by Dickens\' Scrooge.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['HUMBUG', 'BUNKUM', 'TWADDLE', 'CLAPTRAP'],
    ),
    PuzzleCategory(
      id: 'rub-a',
      label: 'American rubbish',
      etymology: '1920s US; origin disputed — possibly from Irish surname.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['MALARKEY', 'BALONEY', 'COCKAMAMIE', 'BUBKES'],
    ),
    PuzzleCategory(
      id: 'rub-k',
      label: 'Archaic rubbish',
      etymology: '1920s US; coined by cartoonist Billy DeBeck as a minced euphemism.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['HORSEFEATHERS', 'BUSHWA', 'FLAPDOODLE', 'HORNSWOGGLE'],
    ),
  ],
);
