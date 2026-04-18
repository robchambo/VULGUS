import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Words for Stupid
const vulgus063 = Puzzle(
  id: 'VULGUS-063',
  categories: [
    PuzzleCategory(
      id: 'stupid-easy',
      label: 'Obviously stupid',
      etymology: 'Blunt monosyllables for the dim — lumps of earth, lumps of blood, a schoolman, and a block.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['CLOD', 'CLOT', 'DUNCE', 'CHUMP'],
    ),
    PuzzleCategory(
      id: 'stupid-heavy',
      label: 'Heavy stupid',
      etymology: 'Words implying physical bulk or rural thickness matched by mental emptiness.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GALOOT', 'BOOR', 'OAFS', 'YOKEL'],
    ),
    PuzzleCategory(
      id: 'stupid-food',
      label: 'Edibly stupid',
      etymology: 'Foods that double as insults for the dim — limp, dense, a dud, and herb-brained.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['NOODLE', 'TURNIP', 'LEMON', 'DILL'],
    ),
    PuzzleCategory(
      id: 'stupid-shakes',
      label: 'Shakespearean stupid',
      etymology: 'The Bard\'s fools — clot-headed, moon-born, fat and stale, and gullible as a fish.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CLOTPOLE', 'MOONCALF', 'FUSTILUGS', 'GUDGEON'],
    ),
  ],
);
