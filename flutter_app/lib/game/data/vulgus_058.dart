import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Kiddie Cusses
const vulgus058 = Puzzle(
  id: 'VULGUS-058',
  categories: [
    PuzzleCategory(
      id: 'kid-poo',
      label: 'Playground poo words',
      etymology: 'The schoolyard scatological lexicon — bodily functions as the height of wit.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DOODOO', 'BOOGER', 'POOPYHEAD', 'STINKER'],
    ),
    PuzzleCategory(
      id: 'kid-mean',
      label: 'Playground meanies',
      etymology: 'What children call each other — mean, badly behaved, small, and silly.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['MEANIE', 'BRATS', 'TWERP', 'NINNY'],
    ),
    PuzzleCategory(
      id: 'kid-butt',
      label: 'Playground insults',
      etymology: 'Slightly edgier playground words — anatomy, feebleness, telling tales, and being in trouble.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BUTTHEAD', 'WEENIE', 'TATTLE', 'PICKLE'],
    ),
    PuzzleCategory(
      id: 'kid-cross',
      label: 'Adult words kids stole',
      etymology: 'Words that crossed from adult slang into playground use — a fool, a weirdo, a mistake, and a silly sausage.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['DORK', 'KOOK', 'BOOB', 'SAUSAGE'],
    ),
  ],
);
