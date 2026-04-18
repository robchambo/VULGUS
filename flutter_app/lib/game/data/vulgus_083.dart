import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Aussie Rules
const vulgus083 = Puzzle(
  id: 'VULGUS-083',
  categories: [
    PuzzleCategory(
      id: 'aussie-fool',
      label: 'Aussie fools',
      etymology: 'Australian words for the dim — an herb, a nothing, a slow racehorse, and a pink cockatoo.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DILL', 'NONG', 'DRONGO', 'GALAH'],
    ),
    PuzzleCategory(
      id: 'aussie-rogue',
      label: 'Aussie rogues',
      etymology: 'Australian words for troublemakers — scoundrels, hooligans, failures, and louts.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['RATBAG', 'LARRIKIN', 'DROPKICK', 'YOBBO'],
    ),
    PuzzleCategory(
      id: 'aussie-adj',
      label: 'Aussie descriptors',
      etymology: 'Australian descriptors — a freeloader, a daggy person, a killjoy, and a dullard.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BLUDGER', 'DAG', 'WOWSER', 'MONG'],
    ),
    PuzzleCategory(
      id: 'aussie-shared',
      label: 'Shared with Britain',
      etymology: 'Words shared between Australian and British/American English — a clumsy oaf, a loser, an uncultured person, and an exclamation.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GALOOT', 'PALOOKA', 'BOGAN', 'STREWTH'],
    ),
  ],
);
