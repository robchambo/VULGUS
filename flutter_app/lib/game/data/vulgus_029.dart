import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Archaic Revival
const vulgus029 = Puzzle(
  id: 'VULGUS-029',
  categories: [
    PuzzleCategory(
      id: 'arch-shake',
      label: 'Shakespearean vocabulary',
      etymology: 'Contraction of \'God\'s wounds\' — 16th C oath.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['ZOUNDS', 'EGAD', 'GADZOOKS', 'VARLET'],
    ),
    PuzzleCategory(
      id: 'arch-vict',
      label: 'Victorian vocabulary',
      etymology: 'Mid-18th C; made famous by Dickens\' Scrooge.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['HUMBUG', 'CODSWALLOP', 'POPPYCOCK', 'BALDERDASH'],
    ),
    PuzzleCategory(
      id: 'arch-front',
      label: 'Frontier vocabulary',
      etymology: '18th C US; blend of \'eternal\' and \'damnation\'.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['TARNATION', 'CONSARN', 'SNOLLYGOSTER', 'CATTYWAMPUS'],
    ),
    PuzzleCategory(
      id: 'arch-mil',
      label: 'Old military vocabulary',
      etymology: 'WWII US military acronym: Situation Normal, All F***ed Up.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNAFU', 'FUBAR', 'BOHICA', 'TARFU'],
    ),
  ],
);
