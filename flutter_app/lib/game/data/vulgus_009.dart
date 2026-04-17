import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Foods That Fight Back
const vulgus009 = Puzzle(
  id: 'VULGUS-009',
  categories: [
    PuzzleCategory(
      id: 'food-swears',
      label: 'Words that are also foods',
      etymology: 'Stand-in for a stronger s-word; established 20th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SUGAR', 'FUDGE', 'CRUMBS', 'BALONEY'],
    ),
    PuzzleCategory(
      id: 'animals',
      label: 'Animals used as insults',
      etymology: 'Derogatory use since 14th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['PIG', 'RATS', 'TURKEY', 'JACKASS'],
    ),
    PuzzleCategory(
      id: 'salty-slang',
      label: 'American food-flavoured slang',
      etymology: '2010s US internet slang; \'bitter or resentful\'. Earlier Navy slang too.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SALTY', 'GOOBER', 'PEANUT', 'CRUD'],
    ),
    PuzzleCategory(
      id: 'eponymous',
      label: 'Words named after people',
      etymology: 'Biblical hunter; inverted to \'fool\' by Bugs Bunny\'s mocking use (1940s).',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['NIMROD', 'CRAPPER', 'SNOLLYGOSTER', 'MOUNTEBANK'],
    ),
  ],
);
