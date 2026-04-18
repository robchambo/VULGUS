import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Grand Tour
const vulgus080 = Puzzle(
  id: 'VULGUS-080',
  categories: [
    PuzzleCategory(
      id: 'tour-brit',
      label: 'Best of British',
      etymology: 'The essential British quartet — an intensifier, a surprise, a fool, and nonsense.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BLOODY', 'BLIMEY', 'MUPPET', 'BOLLOCKS'],
    ),
    PuzzleCategory(
      id: 'tour-us',
      label: 'Best of American',
      etymology: 'The essential American quartet — an oath, a fool, nonsense, and an animal insult.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DAGNABBIT', 'DOOFUS', 'MALARKEY', 'JACKASS'],
    ),
    PuzzleCategory(
      id: 'tour-oz',
      label: 'Best of Australian',
      etymology: 'The essential Australian quartet — a fool, a layabout, a scoundrel, and an exclamation.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['DRONGO', 'BLUDGER', 'RATBAG', 'STREWTH'],
    ),
    PuzzleCategory(
      id: 'tour-celtic2',
      label: 'Best of Celtic',
      etymology: 'The essential Irish quartet — a fool, broken, a loudmouth, and the national intensifier.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['EEJIT', 'BANJAXED', 'GOBSHITE', 'FECKIN'],
    ),
  ],
);
