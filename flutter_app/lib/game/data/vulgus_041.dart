import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Strong Medicine
const vulgus041 = Puzzle(
  id: 'VULGUS-041',
  categories: [
    PuzzleCategory(
      id: 'strong-brit',
      label: 'Classic strong British',
      etymology: 'Likely from \'by our Lady\'; disputed. Mild UK intensifier.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BLOODY', 'BUGGER', 'ARSE', 'BOLLOCKS'],
    ),
    PuzzleCategory(
      id: 'ptier-brit',
      label: 'Top-shelf British',
      etymology: 'The sharper end of British vocabulary.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['WANKER', 'GOBSHITE', 'KNACKERS', 'COW'],
    ),
    PuzzleCategory(
      id: 'celtic-strong',
      label: 'Celtic strength',
      etymology: 'Irish/Scots minced swears — "feckin" is the Irish "f***ing" substitute.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['FECKIN', 'EEJIT', 'BAMPOT', 'GORRAM'],
    ),
    PuzzleCategory(
      id: 'intensifiers',
      label: 'American intensifiers',
      etymology: 'From Old French \'damner\' → to condemn; softened to a general intensifier.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['DAMN', 'HELLFIRE', 'BEJESUS', 'WICKED'],
    ),
  ],
);
