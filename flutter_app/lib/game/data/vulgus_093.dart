import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Verbal Venom
const vulgus093 = Puzzle(
  id: 'VULGUS-093',
  categories: [
    PuzzleCategory(
      id: 'venom-mild',
      label: 'Mild venom',
      etymology: 'The mildest poison — you\'re rotten, blighted, stinking, and foot-wrapping.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['STINKER', 'ROTTER', 'BLIGHTER', 'TOERAG'],
    ),
    PuzzleCategory(
      id: 'venom-strong',
      label: 'Strong venom',
      etymology: 'British strong venom — action-based, appearance-based, and anatomical.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['TOSSER', 'MINGER', 'TWATS', 'PRATS'],
    ),
    PuzzleCategory(
      id: 'venom-ancient',
      label: 'Ancient venom',
      etymology: 'Medieval poison — the black guard, the captive wretch, the base knave, and the rude peasant.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BLACKGUARD', 'CAITIFF', 'CULLION', 'CHURL'],
    ),
    PuzzleCategory(
      id: 'venom-celtic2',
      label: 'Celtic venom',
      etymology: 'Celtic poison — Scottish anatomy, Irish howling, being made a fool of, and Highland snobbery.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BAWBAG', 'GOWL', 'ROASTER', 'TEUCHTER'],
    ),
  ],
);
