import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

const vulgus007 = Puzzle(
  id: 'VULGUS-007',
  categories: [
    PuzzleCategory(
      id: 'dim',
      label: 'Words for Stupid',
      etymology: '',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['GORMLESS', 'WITLESS', 'VAPID', 'OBTUSE'],
    ),
    PuzzleCategory(
      id: 'codger',
      label: 'Words for an Old Man',
      etymology: '',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CODGER', 'GEEZER', 'FOGEY', 'BUFFER'],
    ),
    PuzzleCategory(
      id: 'hokum',
      label: 'Words for Deceptive Nonsense',
      etymology: '',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['HUMBUG', 'HOKUM', 'FLIMFLAM', 'MALARKEY'],
    ),
    PuzzleCategory(
      id: 'niggle',
      label: 'Subtle Words for Annoy',
      etymology: '',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['VEX', 'IRK', 'NETTLE', 'RANKLE'],
    ),
  ],
);
