import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Pub Quiz
const vulgus076 = Puzzle(
  id: 'VULGUS-076',
  categories: [
    PuzzleCategory(
      id: 'pub-anatomy2',
      label: 'Pub body talk',
      etymology: 'The coarser end of pub vocabulary — anatomy and the rounded bit on top.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['KNOB', 'PRATS', 'TWATS', 'BONCE'],
    ),
    PuzzleCategory(
      id: 'pub-mild',
      label: 'Pub mild insults',
      etymology: 'The milder end of pub banter — fools, featherweights, and lightweights.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['NITWIT', 'TWIT', 'TWERP', 'NINNY'],
    ),
    PuzzleCategory(
      id: 'pub-animal',
      label: 'Pub animal insults',
      etymology: 'When pub insults go zoological — stubborn, slimy, sneaky, and mangy.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['DONKEY', 'TOAD', 'RAT', 'CUR'],
    ),
    PuzzleCategory(
      id: 'pub-cockney2',
      label: 'Pub Cockney',
      etymology: 'Cockney slang overheard at the bar — drunk, lying, unfashionable, and silly.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BRAHMS', 'PORKY', 'NAFF', 'DIPPY'],
    ),
  ],
);
