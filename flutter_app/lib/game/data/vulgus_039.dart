import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Down South
const vulgus039 = Puzzle(
  id: 'VULGUS-039',
  categories: [
    PuzzleCategory(
      id: 'midwest',
      label: 'Regional Americana',
      etymology: 'Distinct regional Americanisms — Midwest "ope," Southern "reckon," Scandinavian-American "uff da," Minnesotan "don\'t cha know."',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['OPE', 'RECKON', 'UFF DA', 'DON\'T CHA KNOW'],
    ),
    PuzzleCategory(
      id: 'southern-oath',
      label: 'Southern oaths',
      etymology: 'Ozark/Southern US minced form of \'God damn it\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DAGNABBIT', 'TARNATION', 'CONSARN', 'CRIMINY'],
    ),
    PuzzleCategory(
      id: 'frontier',
      label: 'Frontier imagery',
      etymology: 'Cowboy origin — to tie a hog\'s legs; \'stuck, restrained\'.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['HOG-TIED', 'HORNSWOGGLE', 'CATTYWAMPUS', 'COCKAMAMIE'],
    ),
    PuzzleCategory(
      id: 'southern-phrase',
      label: 'Southern phrases',
      etymology: 'Southern US phrases — politeness, shock, and passive aggression in roughly equal measure.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BLESS YOUR HEART', 'HEAVENS TO BETSY', 'MERCY ME', 'CHEESE AND RICE'],
    ),
  ],
);
