import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Double Meaning
const vulgus078 = Puzzle(
  id: 'VULGUS-078',
  categories: [
    PuzzleCategory(
      id: 'double-food',
      label: 'Food or insult?',
      etymology: 'Words that could appear on a menu or in a rant — in trouble, silly, crazy, and certifiable.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['PICKLE', 'SAUSAGE', 'FRUITCAKE', 'NUTCASE'],
    ),
    PuzzleCategory(
      id: 'double-animal',
      label: 'Animal or insult?',
      etymology: 'Zoo creatures that double as character assessments — ugly, stubborn, sneaky, and treacherous.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['TOAD', 'DONKEY', 'RAT', 'WEASEL'],
    ),
    PuzzleCategory(
      id: 'double-theatre',
      label: 'Theatre or insult?',
      etymology: 'Stage terminology that doubles as everyday contempt — overact, fail, freeze, and steal focus.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['HAM', 'FLOP', 'CORPSE', 'UPSTAGE'],
    ),
    PuzzleCategory(
      id: 'double-hidden',
      label: 'Hidden doubles',
      etymology: 'Innocent-sounding food words with a second life as insults — attractive, cheap, dud, and thick.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CRUMPET', 'PLONK', 'LEMON', 'TURNIP'],
    ),
  ],
);
