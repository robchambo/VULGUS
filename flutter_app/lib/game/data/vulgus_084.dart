import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Old Blighty
const vulgus084 = Puzzle(
  id: 'VULGUS-084',
  categories: [
    PuzzleCategory(
      id: 'blighty-mild',
      label: 'Mild British',
      etymology: 'The gentlest British exclamations — from "God blind me" to biscuit crumbs.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BLIMEY', 'CRIKEY', 'STREWTH', 'CRUMBS'],
    ),
    PuzzleCategory(
      id: 'blighty-mid',
      label: 'Mid-range British',
      etymology: 'Britain\'s favourite fools — a plonk, a pill, a nit-wit, and a wally.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['PLONKER', 'PILLOCK', 'NITWIT', 'WALLY'],
    ),
    PuzzleCategory(
      id: 'blighty-strong',
      label: 'Strong British',
      etymology: 'Britain at full volume — action-based, ugly, and loud.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['TOSSER', 'WANKER', 'MINGER', 'GOBSHITE'],
    ),
    PuzzleCategory(
      id: 'blighty-posh',
      label: 'Posh British',
      etymology: 'The upper-class British insult — gentlemen villains and street urchins.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CAD', 'BOUNDER', 'BLACKGUARD', 'GUTTERSNIPE'],
    ),
  ],
);
