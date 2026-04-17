import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Animals in Disguise
const vulgus015 = Puzzle(
  id: 'VULGUS-015',
  categories: [
    PuzzleCategory(
      id: 'bird-fools',
      label: 'Birds used as insults',
      etymology: 'From an Australian racehorse (1920s) that never won; then bird → fool.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DRONGO', 'GALAH', 'TURKEY', 'JACKASS'],
    ),
    PuzzleCategory(
      id: 'animals2',
      label: 'Animal-named swears',
      etymology: 'Derogatory use since 14th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['PIG', 'RATS', 'COW', 'GOOBER'],
    ),
    PuzzleCategory(
      id: 'eponym2',
      label: 'Eponymous curiosities',
      etymology: 'Biblical hunter; inverted to \'fool\' by Bugs Bunny\'s mocking use (1940s).',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['NIMROD', 'CRAPPER', 'SNOLLYGOSTER', 'PALOOKA'],
    ),
    PuzzleCategory(
      id: 'us-mild2',
      label: 'Mild US words',
      etymology: 'Southern US minced form of \'damn\'; 18th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DANG', 'HECK', 'CRUD', 'SHUCKS'],
    ),
  ],
);
