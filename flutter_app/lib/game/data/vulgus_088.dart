import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Mixed Metaphors
const vulgus088 = Puzzle(
  id: 'VULGUS-088',
  categories: [
    PuzzleCategory(
      id: 'meta-animal',
      label: 'Animal metaphors',
      etymology: 'Animals as character types — stubborn, repulsive, chattering, and mangy.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DONKEY', 'TOAD', 'MAGPIE', 'CUR'],
    ),
    PuzzleCategory(
      id: 'meta-food',
      label: 'Food metaphors',
      etymology: 'Food as personality types — crazy, silly, in trouble, and bonkers.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['FRUITCAKE', 'SAUSAGE', 'PICKLE', 'BANANA'],
    ),
    PuzzleCategory(
      id: 'meta-body2',
      label: 'Body metaphors',
      etymology: 'The head made of something other than brain — bone, lunk, meat, and butt.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BONEHEAD', 'LUNKHEAD', 'MEATHEAD', 'BUTTHEAD'],
    ),
    PuzzleCategory(
      id: 'meta-nature',
      label: 'Shakespearean nature',
      etymology: 'Shakespearean nature metaphors for human failing — disease, prickly, lunar, and a greedy kite.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CANKER', 'HEDGE-PIG', 'MOONCALF', 'PUTTOCK'],
    ),
  ],
);
