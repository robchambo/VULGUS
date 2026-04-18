import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Potty Mouth
const vulgus082 = Puzzle(
  id: 'VULGUS-082',
  categories: [
    PuzzleCategory(
      id: 'potty-mild',
      label: 'Mild potty words',
      etymology: 'The softer end of scatological vocabulary — what you say when children are present.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['CRAP', 'CRUD', 'DOODOO', 'DRECK'],
    ),
    PuzzleCategory(
      id: 'potty-strong',
      label: 'Strong potty words',
      etymology: 'The stronger end — anatomy-adjacent and action-based.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CRAPPER', 'BOLLOCKS', 'TOSSER', 'KNACKERS'],
    ),
    PuzzleCategory(
      id: 'potty-nonsense',
      label: 'Potty-to-nonsense pipeline',
      etymology: 'Words that bridged waste and worthlessness — from actual filth to metaphorical rubbish.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['TRIPE', 'GUBBINS', 'PIFFLE', 'TWADDLE'],
    ),
    PuzzleCategory(
      id: 'potty-cross',
      label: 'Potty crossovers',
      etymology: 'Words that sound clean but have scatological or filthy origins.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GUFF', 'BILGE', 'TOSH', 'HOGWASH'],
    ),
  ],
);
