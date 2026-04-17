import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

const vulgus006 = Puzzle(
  id: 'VULGUS-006',
  categories: [
    PuzzleCategory(
      id: 'stroppy',
      label: 'Irritable and Bad-Tempered',
      etymology: '',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['STROPPY', 'SHIRTY', 'TETCHY', 'SNAPPY'],
    ),
    PuzzleCategory(
      id: 'mosey',
      label: 'Ways to Walk Without Hurry',
      etymology: '',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['LOLLYGAG', 'DAWDLE', 'MOSEY', 'AMBLE'],
    ),
    PuzzleCategory(
      id: 'flummox',
      label: 'Ways to Utterly Confuse',
      etymology: '',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['FLUMMOX', 'BAMBOOZLE', 'BEFUDDLE', 'DISCOMBOBULATE'],
    ),
    PuzzleCategory(
      id: 'oaf',
      label: 'Words for a Clumsy Person',
      etymology: '',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['LUMMOX', 'OAF', 'GALOOT', 'LUBBER'],
    ),
  ],
);
