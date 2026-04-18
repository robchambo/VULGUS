import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Insult Alphabet
const vulgus086 = Puzzle(
  id: 'VULGUS-086',
  categories: [
    PuzzleCategory(
      id: 'alpha-b',
      label: 'B insults',
      etymology: 'The letter B brings the blunt force — beauty without brains, a mistake, a lout, and bad children.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BIMBO', 'BOOB', 'BOOR', 'BRATS'],
    ),
    PuzzleCategory(
      id: 'alpha-c',
      label: 'C insults',
      etymology: 'The letter C cuts — a rude peasant, a lump, a mongrel, and a blood clot.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CHURL', 'CLOD', 'CUR', 'CLOT'],
    ),
    PuzzleCategory(
      id: 'alpha-d',
      label: 'D insults',
      etymology: 'The letter D delivers — a cowardly villain, a scholar turned fool, a silly one, and a rough sleeper.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['DASTARD', 'DUNCE', 'DIPPY', 'DOSSER'],
    ),
    PuzzleCategory(
      id: 'alpha-g',
      label: 'G insults',
      etymology: 'The letter G gets grim — a street urchin, a Celtic howler, a cuckoo fool, and a lame one.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GUTTERSNIPE', 'GOWL', 'GOWK', 'GIMP'],
    ),
  ],
);
