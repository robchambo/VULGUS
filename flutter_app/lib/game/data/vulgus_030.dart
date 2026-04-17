import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Grand Finale
const vulgus030 = Puzzle(
  id: 'VULGUS-030',
  categories: [
    PuzzleCategory(
      id: 'fin-brit',
      label: 'Best British',
      etymology: 'Old English \'beallucas\' (testicles); by the 1860s meant \'nonsense\'; Sex Pistols 1977.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'ARSE', 'BLIMEY', 'CRIKEY'],
    ),
    PuzzleCategory(
      id: 'fin-us',
      label: 'Best American',
      etymology: '1920s US; origin disputed — possibly from Irish surname.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['MALARKEY', 'BALONEY', 'COCKAMAMIE', 'BUBKES'],
    ),
    PuzzleCategory(
      id: 'fin-arch',
      label: 'Best archaic',
      etymology: 'Contraction of \'God\'s wounds\' — 16th C oath.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['ZOUNDS', 'EGAD', 'HORSEFEATHERS', 'SNOLLYGOSTER'],
    ),
    PuzzleCategory(
      id: 'fin-fools',
      label: 'Best words for fools',
      etymology: '1980s UK slang from Jim Henson\'s Muppets; gentle insult.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['MUPPET', 'WALLY', 'DOOFUS', 'NUMPTY'],
    ),
  ],
);
