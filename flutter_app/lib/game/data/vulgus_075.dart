import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Thick as a Plank
const vulgus075 = Puzzle(
  id: 'VULGUS-075',
  categories: [
    PuzzleCategory(
      id: 'thick-brit',
      label: 'British thick words',
      etymology: 'British English words for someone who is not the sharpest tool in the shed.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['PLONKER', 'MUPPET', 'WALLY', 'TWIT'],
    ),
    PuzzleCategory(
      id: 'thick-us',
      label: 'American thick words',
      etymology: 'American English equivalents — from 1960s slang to biblical inversions.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DOOFUS', 'NIMROD', 'DINGBAT', 'CHUMP'],
    ),
    PuzzleCategory(
      id: 'thick-food2',
      label: 'Edibly thick',
      etymology: 'Fruits, nuts, and baked goods — all meaning someone is soft in the head.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BANANA', 'LEMON', 'CRUMPET', 'NOODLE'],
    ),
    PuzzleCategory(
      id: 'thick-arch',
      label: 'Archaically thick',
      etymology: 'Old words for the dim — a medieval scholar, a lump of earth, a blood clot, and a gullible fish.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['DUNCE', 'CLOD', 'CLOT', 'GUDGEON'],
    ),
  ],
);
