import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

const vulgus004 = Puzzle(
  id: 'VULGUS-004',
  categories: [
    PuzzleCategory(
      id: 'yap',
      label: 'Ways to Talk Too Much',
      etymology: '',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['NATTER', 'JABBER', 'GABBLE', 'PRATTLE'],
    ),
    PuzzleCategory(
      id: 'flee',
      label: 'Ways to Run Away',
      etymology: '',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SCARPER', 'VAMOOSE', 'SKEDADDLE', 'SCRAM'],
    ),
    PuzzleCategory(
      id: 'idle',
      label: 'Words for a Lazy Person',
      etymology: '',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['LAYABOUT', 'LOAFER', 'SLACKER', 'DOSSER'],
    ),
    PuzzleCategory(
      id: 'braggart',
      label: 'Words for a Boastful Person',
      etymology: '',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BLOWHARD', 'WINDBAG', 'GASBAG', 'BIGMOUTH'],
    ),
  ],
);
