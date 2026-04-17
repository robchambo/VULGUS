import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Stand-Ins
const vulgus032 = Puzzle(
  id: 'VULGUS-032',
  categories: [
    PuzzleCategory(
      id: 'food-sub',
      label: 'Food-based substitutes',
      etymology: 'American tradition: swap a sweary word for a food-word of roughly the same shape.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SUGAR', 'FUDGE', 'PEANUT', 'GOOBER'],
    ),
    PuzzleCategory(
      id: 'mild-us',
      label: 'Mild American stand-ins',
      etymology: 'American euphemism for s-word; 19th C onwards.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SHOOT', 'DANG', 'DARN', 'HECK'],
    ),
    PuzzleCategory(
      id: 'scifi',
      label: 'Made-up swears',
      etymology: 'Invented to sound sweary without being sweary — some from TV, others just creative linguistic dodges.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['FRAK', 'SMEG', 'DOOZY', 'GORRAM'],
    ),
    PuzzleCategory(
      id: 'elaborate',
      label: 'Elaborate avoidances',
      etymology: 'The longer the euphemism, the further from the actual swear — Victorian-style padding.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['FIDDLE-FADDLE', 'FIDDLESTICKS', 'BUSHWA', 'HORSEFEATHERS'],
    ),
  ],
);
