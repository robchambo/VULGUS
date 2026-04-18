import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Military Manoeuvres II
const vulgus077 = Puzzle(
  id: 'VULGUS-077',
  categories: [
    PuzzleCategory(
      id: 'mil-acro2',
      label: 'Military acronyms',
      etymology: 'The military alphabet soup of disaster — each hiding profanity behind official-sounding letters.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SNAFU', 'FUBAR', 'TARFU', 'CHARLIE FOXTROT'],
    ),
    PuzzleCategory(
      id: 'mil-insult2',
      label: 'Military insults',
      etymology: 'What soldiers call those who avoid the fight — rear-echelon, pathetic, dodging, and slack.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['POGUE', 'SAD SACK', 'SHIRKER', 'SLACKER'],
    ),
    PuzzleCategory(
      id: 'mil-chaos2',
      label: 'Military chaos words',
      etymology: 'Military words for an operation gone sideways — animal husbandry, munitions, bending over, and broken.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['GOAT ROPE', 'CLUSTER', 'BOHICA', 'BUSTED'],
    ),
    PuzzleCategory(
      id: 'mil-cross',
      label: 'Medieval military vocabulary',
      etymology: 'Medieval military vocabulary for cowardice that crossed into civilian use.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CRAVEN', 'DASTARD', 'CAITIFF', 'MISCREANT'],
    ),
  ],
);
