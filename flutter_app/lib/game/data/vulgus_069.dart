import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Work-Shy
const vulgus069 = Puzzle(
  id: 'VULGUS-069',
  categories: [
    PuzzleCategory(
      id: 'workshy-brit',
      label: 'British work-dodgers',
      etymology: 'Four ways to say someone avoids work — cutting, ducking, lying about, and being slack.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SKIVER', 'SHIRKER', 'LAYABOUT', 'SLACKER'],
    ),
    PuzzleCategory(
      id: 'workshy-posh',
      label: 'Posh idlers',
      etymology: 'Upper-class words for those who waste their privilege — or who never had any.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CAD', 'BOUNDER', 'WASTREL', 'PLEB'],
    ),
    PuzzleCategory(
      id: 'workshy-aus',
      label: 'Antipodean work-dodgers',
      etymology: 'Australian English for the idle, the daggy, the puritanical, and the thick.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BLUDGER', 'DAG', 'WOWSER', 'NONG'],
    ),
    PuzzleCategory(
      id: 'workshy-cockney',
      label: 'Cockney work-dodgers',
      etymology: 'London street slang for the homeless, the sponger, the lame, and the old man.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['DOSSER', 'PONCE', 'GIMP', 'GEEZER'],
    ),
  ],
);
