import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Celtic Thunder
const vulgus055 = Puzzle(
  id: 'VULGUS-055',
  categories: [
    PuzzleCategory(
      id: 'celtic-anger',
      label: 'Celtic anger words',
      etymology: 'Irish and Scots words for being broken, being a fool, being ridiculous, and talking nonsense.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BANJAXED', 'GOWL', 'ROASTER', 'BLETHER'],
    ),
    PuzzleCategory(
      id: 'celtic-scot',
      label: 'Scottish insults',
      etymology: 'Scottish English: an insignificant person, a rural yokel, anatomy, and an ugly one.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['NYAFF', 'TEUCHTER', 'BAWBAG', 'MINGER'],
    ),
    PuzzleCategory(
      id: 'celtic-irish',
      label: 'Irish rogues',
      etymology: 'Irish English: a moneylender, a loudmouth, an idiot, and the national minced oath.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['GOMBEEN', 'GOBSHITE', 'EEJIT', 'FECKIN'],
    ),
    PuzzleCategory(
      id: 'celtic-cross',
      label: 'Celtic crossovers',
      etymology: 'Words shared across Celtic regions — a cuckoo/fool, a crazy person, a useless one, and a killjoy.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GOWK', 'BAMPOT', 'NUMPTY', 'NARK'],
    ),
  ],
);
