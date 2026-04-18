import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Workplace Woes
const vulgus095 = Puzzle(
  id: 'VULGUS-095',
  categories: [
    PuzzleCategory(
      id: 'work-lazy',
      label: 'Workplace layabouts',
      etymology: 'Four ways to describe the colleague who coasts — cutting corners, ducking, and hacking it.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SKIVER', 'SHIRKER', 'SLACKER', 'HACK'],
    ),
    PuzzleCategory(
      id: 'work-petty',
      label: 'Workplace petty tyrants',
      etymology: 'The office killjoy, the tattler, the complainer, and the sulker.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['JOBSWORTH', 'NARK', 'GRIPE', 'SNIT'],
    ),
    PuzzleCategory(
      id: 'work-strong',
      label: 'What you call them privately',
      etymology: 'What British workers actually call difficult colleagues — behind their backs.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['TOSSER', 'PLONKER', 'MUPPET', 'TWIT'],
    ),
    PuzzleCategory(
      id: 'work-celtic3',
      label: 'Celtic workplace',
      etymology: 'Celtic words for the colleague who talks too much, achieves too little, and howls about it.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['NYAFF', 'BLETHER', 'ROASTER', 'GOWL'],
    ),
  ],
);
