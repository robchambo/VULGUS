import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Victorian Values
const vulgus016 = Puzzle(
  id: 'VULGUS-016',
  categories: [
    PuzzleCategory(
      id: 'vict-easy',
      label: 'Easy Victorian words',
      etymology: 'From violin bows being flimsy and trivial; 17th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['FIDDLESTICKS', 'PHOOEY', 'CRIKEY', 'CRUMBS'],
    ),
    PuzzleCategory(
      id: 'vict-med',
      label: 'Victorian words for nonsense',
      etymology: 'Late 18th C, from \'twattle\' (prattle).',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['TWADDLE', 'BUNKUM', 'CLAPTRAP', 'SCOUNDREL'],
    ),
    PuzzleCategory(
      id: 'vict-hard',
      label: 'Victorian-era strong words',
      etymology: 'Old English \'beallucas\' (testicles); by the 1860s meant \'nonsense\'; Sex Pistols 1977.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'ARSE', 'KNACKERS', 'WANKER'],
    ),
    PuzzleCategory(
      id: 'vict-obs',
      label: 'Victorian obscurities',
      etymology: '19th C US — a shrewd, unprincipled politician.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNOLLYGOSTER', 'MOUNTEBANK', 'RAPSCALLION', 'VARLET'],
    ),
  ],
);
