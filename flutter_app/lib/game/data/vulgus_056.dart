import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Food Fight
const vulgus056 = Puzzle(
  id: 'VULGUS-056',
  categories: [
    PuzzleCategory(
      id: 'food-fruit',
      label: 'Fruity insults',
      etymology: 'Calling someone a fruit or vegetable — implying they\'re useless, bonkers, thick, or soft in the head.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['LEMON', 'BANANA', 'TURNIP', 'NOODLE'],
    ),
    PuzzleCategory(
      id: 'food-nut',
      label: 'Nutty insults',
      etymology: 'Food words repurposed to mean crazy, silly, attractive, or daft.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['NUTCASE', 'FRUITCAKE', 'CRUMPET', 'SAUSAGE'],
    ),
    PuzzleCategory(
      id: 'food-brit',
      label: 'British food slang',
      etymology: 'British food words as insults or slang — in trouble, cheap wine, lies, and rubbish.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['PICKLE', 'PLONK', 'PORKY', 'TRIPE'],
    ),
    PuzzleCategory(
      id: 'food-hidden',
      label: 'Hidden food insults',
      etymology: 'Words that are both foods and euphemisms — a fool, something small, biscuit bits, and sliced nonsense.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GOOBER', 'PEANUT', 'CRUMBS', 'BALONEY'],
    ),
  ],
);
