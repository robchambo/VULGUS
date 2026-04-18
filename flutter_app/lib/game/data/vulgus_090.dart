import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Proper Nouns in Disguise
const vulgus090 = Puzzle(
  id: 'VULGUS-090',
  categories: [
    PuzzleCategory(
      id: 'propn-people',
      label: 'Named after people',
      etymology: 'Duns Scotus, the biblical hunter, Thomas Crapper, and Swift\'s savages — real names turned insults.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DUNCE', 'NIMROD', 'CRAPPER', 'YAHOO'],
    ),
    PuzzleCategory(
      id: 'propn-places',
      label: 'Named after places',
      etymology: 'Buncombe County NC, Decalcomania, military acronym, and frontier crooked — all place-adjacent.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BUNKUM', 'COCKAMAMIE', 'BOHICA', 'CATTYWAMPUS'],
    ),
    PuzzleCategory(
      id: 'propn-char',
      label: 'Named after characters',
      etymology: 'Italian couch potatoes, Jack Napes the monkey, Jim Henson\'s felt, and a Cockney disguise.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['POLTROON', 'JACKANAPES', 'MUPPET', 'GEEZER'],
    ),
    PuzzleCategory(
      id: 'propn-eponym',
      label: 'Eponymous insults',
      etymology: 'Words that trace to specific origins — a 19th C politician, a bench-climber, Berkeley Hunt, and a medieval harlot.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNOLLYGOSTER', 'MOUNTEBANK', 'BERK', 'STRUMPET'],
    ),
  ],
);
