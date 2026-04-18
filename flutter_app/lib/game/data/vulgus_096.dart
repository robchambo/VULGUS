import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Desperately Seeking Synonyms
const vulgus096 = Puzzle(
  id: 'VULGUS-096',
  categories: [
    PuzzleCategory(
      id: 'syn-fool',
      label: 'Synonyms for fool',
      etymology: 'Four ways to say fool — no wit, a baby, a small thing, and a medieval scholar.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['NITWIT', 'NINNY', 'TWERP', 'DUNCE'],
    ),
    PuzzleCategory(
      id: 'syn-rogue2',
      label: 'Synonyms for rogue',
      etymology: 'Four progressively more archaic words for the same loveable rogue.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['RAPSCALLION', 'SCALLYWAG', 'KNAVE', 'VARLET'],
    ),
    PuzzleCategory(
      id: 'syn-nonsense',
      label: 'Synonyms for nonsense',
      etymology: 'Four Victorian-adjacent words meaning exactly the same thing — your words are rubbish.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['HOGWASH', 'CODSWALLOP', 'POPPYCOCK', 'BALDERDASH'],
    ),
    PuzzleCategory(
      id: 'syn-coward2',
      label: 'Synonyms for coward',
      etymology: 'Four medieval French-origin words for the spineless — each more obscure than the last.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CRAVEN', 'POLTROON', 'RECREANT', 'CAITIFF'],
    ),
  ],
);
