import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

const vulgus001 = Puzzle(
  id: 'VULGUS-001',
  categories: [
    PuzzleCategory(
      id: 'idiot',
      label: 'Words for Idiot',
      etymology: '',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['NIMROD', 'DOOFUS', 'MUPPET', 'WALLY'],
    ),
    PuzzleCategory(
      id: 'soft',
      label: 'Soft Swears (G-rated)',
      etymology: '',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SUGAR', 'FUDGE', 'SHOOT', 'CRIKEY'],
    ),
    PuzzleCategory(
      id: 'british',
      label: 'British Swears',
      etymology: '',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'ARSE', 'BUM', 'BLIMEY'],
    ),
    PuzzleCategory(
      id: 'nonsense',
      label: 'Words for Nonsense',
      etymology: '',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['TOSH', 'CODSWALLOP', 'POPPYCOCK', 'BALDERDASH'],
    ),
  ],
);
