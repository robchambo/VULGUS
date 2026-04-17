import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Gentleman's Insult
const vulgus010 = Puzzle(
  id: 'VULGUS-010',
  categories: [
    PuzzleCategory(
      id: 'shake2',
      label: 'More Shakespearean insults',
      etymology: 'Origin disputed; 16th C.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SCOUNDREL', 'VARLET', 'RAPSCALLION', 'KNAVE'],
    ),
    PuzzleCategory(
      id: 'vict',
      label: 'Victorian-era words',
      etymology: 'Mid-18th C; made famous by Dickens\' Scrooge.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['HUMBUG', 'CLAPTRAP', 'POPPYCOCK', 'TWADDLE'],
    ),
    PuzzleCategory(
      id: 'archaic2',
      label: 'Archaic rogue terms',
      etymology: '19th C US — a shrewd, unprincipled politician.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNOLLYGOSTER', 'MOUNTEBANK', 'CATTYWAMPUS', 'CONSARN'],
    ),
    PuzzleCategory(
      id: 'brit-rd',
      label: 'British swears (rude)',
      etymology: 'Old English \'beallucas\' (testicles); by the 1860s meant \'nonsense\'; Sex Pistols 1977.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'ARSE', 'KNACKERS', 'BERK'],
    ),
  ],
);
