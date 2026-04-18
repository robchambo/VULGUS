import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Down Under
const vulgus051 = Puzzle(
  id: 'VULGUS-051',
  categories: [
    PuzzleCategory(
      id: 'oz-fools',
      label: 'Australian fools',
      etymology: 'Australian English insults for the dim — from herb names to rugby metaphors.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DILL', 'NONG', 'GALOOT', 'DROPKICK'],
    ),
    PuzzleCategory(
      id: 'oz-rogues',
      label: 'Australian rogues',
      etymology: 'Originally 1850s slang for a pimp (from \'bludgeoner\' — one who carries a bludgeon). By the 1940s in Australia it softened to mean a lazy person or scrounger. J.K. Rowling borrowed it for Quidditch.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BLUDGER', 'LARRIKIN', 'YOBBO', 'RATBAG'],
    ),
    PuzzleCategory(
      id: 'oz-surprise',
      label: 'Surprise words',
      etymology: 'Exclamations of shock — Australian, British, American, and baseball-booth.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['STREWTH', 'CRIKEY', 'GOOD GRIEF', 'HOLY TOLEDO'],
    ),
    PuzzleCategory(
      id: 'oz-obscure',
      label: 'Deep-cut Australian',
      etymology: 'Deep-cut Australianisms: dried sheep dung, a killjoy, a dullard, and an uncultured suburbanite.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['DAG', 'WOWSER', 'MONG', 'BOGAN'],
    ),
  ],
);
