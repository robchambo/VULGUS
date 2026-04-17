import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Surprising Origins
const vulgus022 = Puzzle(
  id: 'VULGUS-022',
  categories: [
    PuzzleCategory(
      id: 'surprise1',
      label: 'Words that started as body parts',
      etymology: 'Originally northern English for penis; meaning \'fool\' from mid-20th C.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['PILLOCK', 'PLONKER', 'DORK', 'DIPSTICK'],
    ),
    PuzzleCategory(
      id: 'surprise2',
      label: 'Words from places',
      etymology: 'From Buncombe County, NC — a congressman\'s 1820 tedious speech.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BUNKUM', 'BOGAN', 'POGUE', 'YAHOO'],
    ),
    PuzzleCategory(
      id: 'surprise3',
      label: 'Words from animals',
      etymology: 'Biblical hunter; inverted to \'fool\' by Bugs Bunny\'s mocking use (1940s).',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['NIMROD', 'DRONGO', 'GALAH', 'TURKEY'],
    ),
    PuzzleCategory(
      id: 'surprise4',
      label: 'Words from fiction',
      etymology: 'Battlestar Galactica (1978 / 2004) — invented profanity.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['FRAK', 'SMEG', 'FRELL', 'GORRAM'],
    ),
  ],
);
