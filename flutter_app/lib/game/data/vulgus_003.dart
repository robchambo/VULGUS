import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

const vulgus003 = Puzzle(
  id: 'VULGUS-003',
  categories: [
    PuzzleCategory(
      id: 'mildly',
      label: 'Mildly Irritated',
      etymology: '',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['MIFFED', 'NARKED', 'PEEVED', 'RATTY'],
    ),
    PuzzleCategory(
      id: 'grub',
      label: 'Informal Words for Food',
      etymology: '',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GRUB', 'NOSH', 'SCOFF', 'TUCKER'],
    ),
    PuzzleCategory(
      id: 'stench',
      label: 'Words for a Bad Smell',
      etymology: '',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['PONG', 'REEK', 'WHIFF', 'NIFF'],
    ),
    PuzzleCategory(
      id: 'privy',
      label: 'Old Words for the Toilet',
      etymology: '',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['PRIVY', 'LATRINE', 'COMMODE', 'OUTHOUSE'],
    ),
  ],
);
