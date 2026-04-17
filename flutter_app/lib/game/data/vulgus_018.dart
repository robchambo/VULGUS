import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Words With a Past
const vulgus018 = Puzzle(
  id: 'VULGUS-018',
  categories: [
    PuzzleCategory(
      id: 'eponym3',
      label: 'Named after a real person',
      etymology: 'Biblical hunter; inverted to \'fool\' by Bugs Bunny\'s mocking use (1940s).',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['NIMROD', 'CRAPPER', 'SNOLLYGOSTER', 'MOUNTEBANK'],
    ),
    PuzzleCategory(
      id: 'rhyme',
      label: 'Rhyming slang (origin revealed)',
      etymology: 'Cockney rhyming slang: Berkshire Hunt → c**t. Most users don\'t know origin.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BERK', 'WANKER', 'PILLOCK', 'KNACKERS'],
    ),
    PuzzleCategory(
      id: 'scifi2',
      label: 'Invented for TV',
      etymology: 'Battlestar Galactica (1978 / 2004) — invented profanity.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['FRAK', 'SMEG', 'FRELL', 'GORRAM'],
    ),
    PuzzleCategory(
      id: 'milit2',
      label: 'Military origin',
      etymology: 'WWII US military acronym: Situation Normal, All F***ed Up.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNAFU', 'FUBAR', 'BOHICA', 'TARFU'],
    ),
  ],
);
