import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

const vulgus002 = Puzzle(
  id: 'VULGUS-002',
  categories: [
    PuzzleCategory(
      id: 'fools',
      label: 'British Words for a Fool',
      etymology: '',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BERK', 'TWIT', 'PRAT', 'NUMPTY'],
    ),
    PuzzleCategory(
      id: 'tipsy',
      label: 'Politely Drunk',
      etymology: '',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['TIPSY', 'MERRY', 'SQUIFFY', 'SLOSHED'],
    ),
    PuzzleCategory(
      id: 'exclaim',
      label: 'Archaic Exclamations',
      etymology: '',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['ZOUNDS', 'EGAD', 'GADZOOKS', 'STREWTH'],
    ),
    PuzzleCategory(
      id: 'rascals',
      label: 'Archaic Words for a Rascal',
      etymology: '',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['VARLET', 'RAPSCALLION', 'SCALLYWAG', 'BOUNDER'],
    ),
  ],
);
