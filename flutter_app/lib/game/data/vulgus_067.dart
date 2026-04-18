import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Proper Rotters
const vulgus067 = Puzzle(
  id: 'VULGUS-067',
  categories: [
    PuzzleCategory(
      id: 'rotter-easy',
      label: 'Easy rogues',
      etymology: 'Mild British words for a person who\'s let you down — rotting, blighting, stinking, and wretched.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['ROTTER', 'BLIGHTER', 'STINKER', 'WRETCH'],
    ),
    PuzzleCategory(
      id: 'rotter-strong',
      label: 'Stronger rogues',
      etymology: 'Victorian and medieval vocabulary for serious villainy.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BLACKGUARD', 'SCOUNDREL', 'MISCREANT', 'ROGUE'],
    ),
    PuzzleCategory(
      id: 'rotter-sneak',
      label: 'Sneaky rogues',
      etymology: 'Animal and underworld metaphors for the untrustworthy — slithering, venomous, sneaky, and dodgy.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['SNAKE', 'VIPER', 'WEASEL', 'SPIV'],
    ),
    PuzzleCategory(
      id: 'rotter-archaic',
      label: 'Archaic rogues',
      etymology: 'Archaic words for moral degenerates — a harlot, a lecher, a charlatan, and a rascal.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['STRUMPET', 'LEWDSTER', 'MOUNTEBANK', 'RAPSCALLION'],
    ),
  ],
);
