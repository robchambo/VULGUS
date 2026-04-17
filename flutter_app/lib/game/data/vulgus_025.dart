import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Scoundrels and Rogues
const vulgus025 = Puzzle(
  id: 'VULGUS-025',
  categories: [
    PuzzleCategory(
      id: 'rogues-k',
      label: 'Shakespearean rogues',
      etymology: 'Medieval: a knight\'s attendant → rogue by 16th C.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['VARLET', 'KNAVE', 'RAPSCALLION', 'MOUNTEBANK'],
    ),
    PuzzleCategory(
      id: 'rogues-b',
      label: 'Victorian rogues',
      etymology: 'Origin disputed; 16th C.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SCOUNDREL', 'YAHOO', 'BOGAN', 'COW'],
    ),
    PuzzleCategory(
      id: 'rogues-r',
      label: 'Ruder rogues',
      etymology: 'Anatomical origin; \'wank\' dates to 1940s British slang — strong insult in UK and AU.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['WANKER', 'GOBSHITE', 'BERK', 'SCHMUCK'],
    ),
    PuzzleCategory(
      id: 'rogues-y',
      label: 'Gentler rogues',
      etymology: '1980s UK slang from Jim Henson\'s Muppets; gentle insult.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['MUPPET', 'WALLY', 'TURKEY', 'NIMROD'],
    ),
  ],
);
