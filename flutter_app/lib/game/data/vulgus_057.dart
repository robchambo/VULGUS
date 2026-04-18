import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Creature Feature
const vulgus057 = Puzzle(
  id: 'VULGUS-057',
  categories: [
    PuzzleCategory(
      id: 'animal-farm',
      label: 'Farmyard insults',
      etymology: 'The barnyard provides endless contempt — stubborn, unpleasant, greedy, and revolting.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DONKEY', 'COW', 'PIG', 'TOAD'],
    ),
    PuzzleCategory(
      id: 'animal-pest',
      label: 'Pest insults',
      etymology: 'Small, unwanted creatures pressed into service as character assessments.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['WEASEL', 'RAT', 'SNAKE', 'VIPER'],
    ),
    PuzzleCategory(
      id: 'animal-bird',
      label: 'Bird-based insults',
      etymology: 'Avian insults — a slow racehorse-bird, a pink cockatoo, a chatterer, and a cuckoo.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['DRONGO', 'GALAH', 'MAGPIE', 'GOWK'],
    ),
    PuzzleCategory(
      id: 'animal-hidden',
      label: 'Secretly animal-based',
      etymology: 'Berk (Cockney: Berkeley Hunt), Turkey (a theatrical flop), Gudgeon (a gullible fish), Puttock (a greedy kite).',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BERK', 'TURKEY', 'GUDGEON', 'PUTTOCK'],
    ),
  ],
);
