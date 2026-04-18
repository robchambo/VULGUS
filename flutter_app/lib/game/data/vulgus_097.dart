import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Across the Pond
const vulgus097 = Puzzle(
  id: 'VULGUS-097',
  categories: [
    PuzzleCategory(
      id: 'pond-brit',
      label: 'British side',
      etymology: 'Words Americans don\'t use — a man, a fool, unfashionable, and ugly.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BLOKE', 'PLONKER', 'NAFF', 'MINGER'],
    ),
    PuzzleCategory(
      id: 'pond-us',
      label: 'American side',
      etymology: 'Words Brits don\'t use — a fool, a scatterbrain, a weirdo, and a weakling.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DOOFUS', 'DINGBAT', 'KOOK', 'WEENIE'],
    ),
    PuzzleCategory(
      id: 'pond-shared',
      label: 'Shared across the pond',
      etymology: 'Words both nations agree on — a donkey-person, waste, condemnation, and its softened form.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['JACKASS', 'CRAP', 'DAMN', 'HECK'],
    ),
    PuzzleCategory(
      id: 'pond-confused',
      label: 'Means different things',
      etymology: 'Words that cause transatlantic confusion — anatomy vs handle, action vs unknown, and Cockney secrets.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['KNOB', 'TOSSER', 'BERK', 'PLEB'],
    ),
  ],
);
