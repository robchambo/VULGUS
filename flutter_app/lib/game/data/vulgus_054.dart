import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Victorian Villains
const vulgus054 = Puzzle(
  id: 'VULGUS-054',
  categories: [
    PuzzleCategory(
      id: 'vic-gent',
      label: 'Victorian gentlemen villains',
      etymology: 'The Victorian gentleman\'s vocabulary for a man who lets the side down.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['CAD', 'BOUNDER', 'ROTTER', 'BLIGHTER'],
    ),
    PuzzleCategory(
      id: 'vic-street',
      label: 'Victorian street insults',
      etymology: 'Victorian words for the low, the idle, and the morally suspect.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GUTTERSNIPE', 'WASTREL', 'BLACKGUARD', 'COVE'],
    ),
    PuzzleCategory(
      id: 'vic-coward',
      label: 'Words for coward',
      etymology: 'Pre-Victorian words for cowardice — from Old French, Italian, and Anglo-Norman.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['CRAVEN', 'POLTROON', 'RECREANT', 'DASTARD'],
    ),
    PuzzleCategory(
      id: 'vic-overlap',
      label: 'Also Victorian (surprisingly)',
      etymology: 'Victorian-era words that survived: a dreamer, a fraud, a tramp\'s foot-wrapping, and a rough sleeper.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['MOONCALF', 'HUMBUG', 'TOERAG', 'DOSSER'],
    ),
  ],
);
