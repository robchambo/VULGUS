import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// British Classics
const vulgus001 = Puzzle(
  id: 'VULGUS-001',
  categories: [
    PuzzleCategory(
      id: 'idiot',
      label: 'Words for Idiot',
      etymology: 'Biblical hunter; inverted to \'fool\' by Bugs Bunny\'s mocking use (1940s).',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['NIMROD', 'DOOFUS', 'MUPPET', 'WALLY'],
    ),
    PuzzleCategory(
      id: 'soft',
      label: 'Soft Swears (G-rated)',
      etymology: 'Stand-in for a stronger s-word; established 20th C.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SUGAR', 'FUDGE', 'SHOOT', 'CRIKEY'],
    ),
    PuzzleCategory(
      id: 'british',
      label: 'British Swears',
      etymology: 'Old English \'beallucas\' (testicles); by the 1860s meant \'nonsense\'; Sex Pistols 1977.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'ARSE', 'BUM', 'BLIMEY'],
    ),
    PuzzleCategory(
      id: 'nonsense',
      label: 'Words for Nonsense',
      etymology: '19th C slang for rubbish; origin disputed.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['TOSH', 'CODSWALLOP', 'POPPYCOCK', 'BALDERDASH'],
    ),
  ],
);
