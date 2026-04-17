import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Cor Blimey!
const vulgus004 = Puzzle(
  id: 'VULGUS-004',
  categories: [
    PuzzleCategory(
      id: 'mild-ex',
      label: 'Mild exclamations of frustration',
      etymology: 'Originally \'husks of no value\' → worthless → mild exclamation.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SHUCKS', 'PHOOEY', 'DRAT', 'CRUMBS'],
    ),
    PuzzleCategory(
      id: 'brit-med',
      label: 'Classic British swears',
      etymology: 'From Medieval Latin \'Bulgarus\' — referring to heretical Bulgarian sect; meaning shifted through centuries.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BUGGER', 'BLOODY', 'SCOUNDREL', 'COW'],
    ),
    PuzzleCategory(
      id: 'brit-hard',
      label: 'Strong British Isles swears',
      etymology: 'From \'knacker\' — a horse slaughterer; slang for testicles since 19th C.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['KNACKERS', 'BERK', 'WANKER', 'GOBSHITE'],
    ),
    PuzzleCategory(
      id: 'shake',
      label: 'Shakespearean insults',
      etymology: 'Medieval: a knight\'s attendant → rogue by 16th C.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['VARLET', 'KNAVE', 'RAPSCALLION', 'MOUNTEBANK'],
    ),
  ],
);
