import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Con Artists
const vulgus074 = Puzzle(
  id: 'VULGUS-074',
  categories: [
    PuzzleCategory(
      id: 'con-classic',
      label: 'Classic frauds',
      etymology: 'Words for the professional deceiver — climbing on benches, politicking, dealing, and sponging.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['MOUNTEBANK', 'SNOLLYGOSTER', 'SPIV', 'PONCE'],
    ),
    PuzzleCategory(
      id: 'con-brit',
      label: 'British frauds',
      etymology: 'British and Irish words for the petty cheat — usurers, rule-followers, snitches, and the crude.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GOMBEEN', 'JOBSWORTH', 'NARK', 'CRASS'],
    ),
    PuzzleCategory(
      id: 'con-arch',
      label: 'Archaic frauds',
      etymology: 'Medieval and early modern words for the wicked — from servant to outright villain.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['KNAVE', 'ROGUE', 'MISCREANT', 'CAITIFF'],
    ),
    PuzzleCategory(
      id: 'con-sneak',
      label: 'Sneaky animals',
      etymology: 'Animals pressed into service as metaphors for human deceit — slithering, stealing, and chattering.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNAKE', 'WEASEL', 'VIPER', 'MAGPIE'],
    ),
  ],
);
