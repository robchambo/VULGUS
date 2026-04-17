import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Foreign Affairs
const vulgus038 = Puzzle(
  id: 'VULGUS-038',
  categories: [
    PuzzleCategory(
      id: 'yiddish',
      label: 'From Yiddish',
      etymology: 'Yiddish-origin American English: "shmok" (penis), "pots" (penis), "klots" (block of wood), "beytsim" (eggs).',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SCHMUCK', 'PUTZ', 'KLUTZ', 'BUBKES'],
    ),
    PuzzleCategory(
      id: 'celtic',
      label: 'From Irish/Scots Gaelic',
      etymology: 'Hiberno-English rendering of \'idiot\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['EEJIT', 'BAMPOT', 'FECKIN', 'NUMPTY'],
    ),
    PuzzleCategory(
      id: 'vic-brit',
      label: 'Victorian British',
      etymology: 'From Dutch \'pappekak\' — soft dung. Polite now, very rude in origin.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['POPPYCOCK', 'CODSWALLOP', 'BALDERDASH', 'TWADDLE'],
    ),
    PuzzleCategory(
      id: 'mil-acr',
      label: 'Military acronyms',
      etymology: 'WWII US military acronym: Situation Normal, All F***ed Up.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNAFU', 'FUBAR', 'BOHICA', 'CHARLIE FOXTROT'],
    ),
  ],
);
