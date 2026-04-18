import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Absolute Nonsense
const vulgus070 = Puzzle(
  id: 'VULGUS-070',
  categories: [
    PuzzleCategory(
      id: 'non-short',
      label: 'Short nonsense',
      etymology: 'One-syllable dismissals — each means your words are worth less than nothing.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['TOSH', 'GUFF', 'TRIPE', 'BILGE'],
    ),
    PuzzleCategory(
      id: 'non-vic',
      label: 'Victorian nonsense',
      etymology: 'The Victorian era produced the finest words for calling something rubbish.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['POPPYCOCK', 'BALDERDASH', 'HUMBUG', 'CLAPTRAP'],
    ),
    PuzzleCategory(
      id: 'non-modern',
      label: 'Modern nonsense',
      etymology: 'More recent additions to the nonsense vocabulary — dribble, trifle, gadgets, and pig-water.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['DRIVEL', 'PIFFLE', 'GUBBINS', 'HOGWASH'],
    ),
    PuzzleCategory(
      id: 'non-us',
      label: 'American nonsense',
      etymology: 'American English\'s finest contributions to calling something a load of rubbish.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['MALARKEY', 'BALONEY', 'BUNKUM', 'FLAPDOODLE'],
    ),
  ],
);
