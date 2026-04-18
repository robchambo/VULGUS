import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Sounds Rude
const vulgus068 = Puzzle(
  id: 'VULGUS-068',
  categories: [
    PuzzleCategory(
      id: 'rude-sound',
      label: 'Rude-sounding words',
      etymology: 'Words that sound exactly as rude as they are — no euphemism needed.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['KNOB', 'TOSSER', 'TWATS', 'PRATS'],
    ),
    PuzzleCategory(
      id: 'rude-mild',
      label: 'Milder than they sound',
      etymology: 'They sound devastating but are technically quite mild — nit-picker, oil-checker, and regional fools.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['NITWIT', 'DIPSTICK', 'PLONKER', 'PILLOCK'],
    ),
    PuzzleCategory(
      id: 'rude-surprise',
      label: 'Ruder than they sound',
      etymology: 'Innocent-sounding words with surprisingly vulgar Cockney origins.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BERK', 'NAFF', 'COBBLERS', 'RASPBERRY'],
    ),
    PuzzleCategory(
      id: 'rude-ancient',
      label: 'Ancient rudeness',
      etymology: 'Shakespearean and medieval words that sound perfectly innocent but meant something cutting.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SCUT', 'CANKER', 'FUSTILUGS', 'PRIBBLING'],
    ),
  ],
);
