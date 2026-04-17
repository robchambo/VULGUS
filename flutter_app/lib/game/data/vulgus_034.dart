import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Rogues' Gallery
const vulgus034 = Puzzle(
  id: 'VULGUS-034',
  categories: [
    PuzzleCategory(
      id: 'animal',
      label: 'Animal-based insults',
      etymology: 'When you want to call someone an animal, pick one.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['COW', 'PIG', 'JACKASS', 'DRONGO'],
    ),
    PuzzleCategory(
      id: 'archaic',
      label: 'Rogues & rascals',
      etymology: 'Medieval: a knight\'s attendant → rogue by 16th C.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['VARLET', 'KNAVE', 'SCOUNDREL', 'POGUE'],
    ),
    PuzzleCategory(
      id: 'yiddish',
      label: 'Yiddish-origin contempt',
      etymology: 'American English loanwords — Yiddish immigrant communities and Swiftian coinages.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['SCHMUCK', 'PUTZ', 'NIMROD', 'YAHOO'],
    ),
    PuzzleCategory(
      id: 'us-political',
      label: 'Political scoundrels',
      etymology: 'American political English: from the 19th C "snollygoster" onward, a rich tradition.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNOLLYGOSTER', 'MOUNTEBANK', 'CRAPPER', 'BOHICA'],
    ),
  ],
);
