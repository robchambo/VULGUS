import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Modern American Slang
const vulgus013 = Puzzle(
  id: 'VULGUS-013',
  categories: [
    PuzzleCategory(
      id: 'gen-z',
      label: 'Gen-Z slang',
      etymology: '1790s US counterfeit coins; \'fake, bad\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BOGUS', 'BUSTED', 'SALTY', 'SHOOK'],
    ),
    PuzzleCategory(
      id: 'gen-z2',
      label: 'More Gen-Z slang',
      etymology: '1980s US hip-hop; \'bad, inferior\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['WACK', 'DISS', 'JANKY', 'OPE'],
    ),
    PuzzleCategory(
      id: 'millennial',
      label: 'Millennial slang',
      etymology: '1960s US drug slang → 1990s hip-hop; \'acting irrationally\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['TRIPPIN', 'CLUSTER', 'POGUE', 'DINGBAT'],
    ),
    PuzzleCategory(
      id: 'old-school',
      label: 'Old-school American slang',
      etymology: '1920s US boxing slang — a mediocre fighter; origin disputed.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['PALOOKA', 'YAHOO', 'KOOK', 'DOOZY'],
    ),
  ],
);
