import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Lost in Translation
const vulgus072 = Puzzle(
  id: 'VULGUS-072',
  categories: [
    PuzzleCategory(
      id: 'yiddish2',
      label: 'Yiddish imports',
      etymology: 'Yiddish-origin American English — each word travelled from Eastern Europe to New York.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SCHMUCK', 'KLUTZ', 'PUTZ', 'NIMROD'],
    ),
    PuzzleCategory(
      id: 'french-loan',
      label: 'French-origin insults',
      etymology: 'Insults borrowed from French and Italian — cowards, charlatans, rascals, and the crude.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['POLTROON', 'MOUNTEBANK', 'RAPSCALLION', 'CRASS'],
    ),
    PuzzleCategory(
      id: 'celtic-loan',
      label: 'Celtic imports',
      etymology: 'Irish and Scottish Gaelic words adopted into English — a usurer, a nobody, a rustic, and broken.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['GOMBEEN', 'NYAFF', 'TEUCHTER', 'BANJAXED'],
    ),
    PuzzleCategory(
      id: 'oz-loan',
      label: 'Australian imports',
      etymology: 'Australian slang that never quite made it to the rest of the world.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['DROPKICK', 'MONG', 'WOWSER', 'DAG'],
    ),
  ],
);
