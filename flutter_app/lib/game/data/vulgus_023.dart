import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Anatomically Challenged
const vulgus023 = Puzzle(
  id: 'VULGUS-023',
  categories: [
    PuzzleCategory(
      id: 'anat-r',
      label: 'Strong anatomy-based words',
      etymology: 'Old English \'beallucas\' (testicles); by the 1860s meant \'nonsense\'; Sex Pistols 1977.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'KNACKERS', 'WANKER', 'SCHMUCK'],
    ),
    PuzzleCategory(
      id: 'anat-b',
      label: 'Medium anatomy-based words',
      etymology: 'Originally northern English for penis; meaning \'fool\' from mid-20th C.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['PILLOCK', 'PLONKER', 'BERK', 'PUTZ'],
    ),
    PuzzleCategory(
      id: 'anat-y',
      label: 'Mild anatomy-based words',
      etymology: 'Dates to 14th C Middle English — probably onomatopoeic.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BUM', 'DORK', 'DIPSTICK', 'NUMPTY'],
    ),
    PuzzleCategory(
      id: 'anat-dis',
      label: 'Anatomy-disguised words',
      etymology: 'Irish slang: \'gob\' (mouth) + \'shite\'; someone who talks nonsense.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GOBSHITE', 'JACKASS', 'COW', 'BOGAN'],
    ),
  ],
);
