import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Medieval Mayhem
const vulgus061 = Puzzle(
  id: 'VULGUS-061',
  categories: [
    PuzzleCategory(
      id: 'med-villain',
      label: 'Medieval villains',
      etymology: 'Medieval words for the dishonest, the faithless, the rude, and the rascal.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['ROGUE', 'MISCREANT', 'CHURL', 'KNAVE'],
    ),
    PuzzleCategory(
      id: 'med-coward',
      label: 'Medieval cowards',
      etymology: 'Old French-derived words for the spineless — captured, cowardly, base, and surrendered.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CAITIFF', 'CRAVEN', 'DASTARD', 'RECREANT'],
    ),
    PuzzleCategory(
      id: 'med-insult',
      label: 'Medieval insults',
      etymology: 'Words for the low-born and the wicked — a mutt, a spendthrift, a servant-rogue, and a villain.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['CUR', 'WASTREL', 'VARLET', 'SCOUNDREL'],
    ),
    PuzzleCategory(
      id: 'med-shake',
      label: 'Medieval meets Shakespeare',
      etymology: 'Where medieval contempt meets the Bard — a base wretch, a disease, an ape, and a greedy kite.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CULLION', 'CANKER', 'JACKANAPES', 'PUTTOCK'],
    ),
  ],
);
