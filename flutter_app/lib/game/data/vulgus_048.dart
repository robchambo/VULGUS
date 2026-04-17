import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Old-Fashioned
const vulgus048 = Puzzle(
  id: 'VULGUS-048',
  categories: [
    PuzzleCategory(
      id: 'arch-oath',
      label: 'Archaic oaths',
      etymology: 'Contraction of \'God\'s wounds\' — 16th C oath.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['ZOUNDS', 'GADZOOKS', 'EGAD', 'CONSARN'],
    ),
    PuzzleCategory(
      id: 'arch-villain',
      label: 'Archaic villains',
      etymology: 'Medieval: a knight\'s attendant → rogue by 16th C.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['VARLET', 'KNAVE', 'SCOUNDREL', 'MOUNTEBANK'],
    ),
    PuzzleCategory(
      id: 'vic-rot',
      label: 'Victorian rubbish',
      etymology: 'From Dutch \'pappekak\' — soft dung. Polite now, very rude in origin.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['POPPYCOCK', 'BALDERDASH', 'TWADDLE', 'HUMBUG'],
    ),
    PuzzleCategory(
      id: 'arch-us',
      label: 'Archaic Americana',
      etymology: '19th C US — a shrewd, unprincipled politician.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNOLLYGOSTER', 'CATTYWAMPUS', 'HORNSWOGGLE', 'FLAPDOODLE'],
    ),
  ],
);
