import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Sounds Like Swearing
const vulgus087 = Puzzle(
  id: 'VULGUS-087',
  categories: [
    PuzzleCategory(
      id: 'sounds-brit',
      label: 'Sounds British-sweary',
      etymology: 'Intensifiers and exclamations that sound like swearing but technically aren\'t.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['RUDDY', 'BLOOMING', 'BLASTED', 'CRIKEY'],
    ),
    PuzzleCategory(
      id: 'sounds-us',
      label: 'Sounds American-sweary',
      etymology: 'American phonetic stand-ins — shoot for sh*t, fudge for f**k, and so on.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SHOOT', 'FUDGE', 'SUGAR', 'HECK'],
    ),
    PuzzleCategory(
      id: 'sounds-arch',
      label: 'Sounds archaic-sweary',
      etymology: 'Archaic words that were once genuine blasphemy — God\'s wounds, God\'s hooks, and consarnit.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['ZOUNDS', 'GADZOOKS', 'CONSARN', 'SAKES'],
    ),
    PuzzleCategory(
      id: 'sounds-celtic2',
      label: 'Sounds Celtic-sweary',
      etymology: 'Celtic words that sound much worse than their dictionary definitions might suggest.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['FECKIN', 'BANJAXED', 'BAWBAG', 'GOWL'],
    ),
  ],
);
