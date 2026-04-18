import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Rhyming Slang
const vulgus060 = Puzzle(
  id: 'VULGUS-060',
  categories: [
    PuzzleCategory(
      id: 'cockney-easy',
      label: 'Cockney basics',
      etymology: 'Cockney-adjacent British slang — off your head, silly, unfashionable, and crazy.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BARMY', 'DIPPY', 'NAFF', 'NUTTY'],
    ),
    PuzzleCategory(
      id: 'cockney-body',
      label: 'Cockney body parts',
      etymology: 'Cockney rhyming slang for anatomy: Hampton Wick, Khyber Pass, cobbler\'s awls, plates of meat.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['HAMPTON', 'KHYBER', 'COBBLERS', 'PLATES'],
    ),
    PuzzleCategory(
      id: 'cockney-action',
      label: 'Cockney actions',
      etymology: 'Raspberry tart (fart), Brahms and Liszt (drunk), porky pies (lies), plonk (cheap wine).',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['RASPBERRY', 'BRAHMS', 'PORKY', 'PLONK'],
    ),
    PuzzleCategory(
      id: 'cockney-cross',
      label: 'Secretly Cockney',
      etymology: 'Words most people don\'t realise are Cockney — Berkeley Hunt, copper\'s nark, bloke, and geezer.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BERK', 'NARK', 'BLOKE', 'GEEZER'],
    ),
  ],
);
