import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The -Head Crew
const vulgus065 = Puzzle(
  id: 'VULGUS-065',
  categories: [
    PuzzleCategory(
      id: 'head-classic',
      label: 'Classic -heads',
      etymology: 'The compound-head insult: your skull is made of bone, meat, knuckle, or worse.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BONEHEAD', 'MEATHEAD', 'KNUCKLEHEAD', 'BUTTHEAD'],
    ),
    PuzzleCategory(
      id: 'head-extended',
      label: 'Extended head family',
      etymology: 'The -head suffix extended — laughing heads, heavy heads, childish heads, and Shakespearean clot-heads.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CHUCKLEHEAD', 'LUNKHEAD', 'POOPYHEAD', 'CLOTPOLE'],
    ),
    PuzzleCategory(
      id: 'head-hidden',
      label: 'Slang words for head',
      etymology: 'Slang words for the head itself — a marble, a noodle, a root vegetable, and a citrus dud.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BONCE', 'NOODLE', 'TURNIP', 'LEMON'],
    ),
    PuzzleCategory(
      id: 'head-body',
      label: 'Other body-part compounds',
      etymology: 'When -head isn\'t enough, try other anatomy — mouth, feet, rats, and below the belt.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GOBSHITE', 'TOERAG', 'RATBAG', 'BAWBAG'],
    ),
  ],
);
