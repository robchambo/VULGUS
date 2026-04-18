import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Rogue's Gallery II
const vulgus089 = Puzzle(
  id: 'VULGUS-089',
  categories: [
    PuzzleCategory(
      id: 'rogue-easy2',
      label: 'Loveable rogues',
      etymology: 'The kind of rogues you\'d cast in a heist movie — rascals with charm.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['RAPSCALLION', 'SCALLYWAG', 'ROGUE', 'LARRIKIN'],
    ),
    PuzzleCategory(
      id: 'rogue-dark',
      label: 'Dark rogues',
      etymology: 'Rogues with no redeeming qualities — black-hearted, faithless, wretched, and cowardly.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BLACKGUARD', 'MISCREANT', 'CAITIFF', 'DASTARD'],
    ),
    PuzzleCategory(
      id: 'rogue-sea',
      label: 'Sea rogues',
      etymology: 'Rogues of the high seas — meat-smokers, plunderers, wretches, and swabs.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BUCCANEER', 'FREEBOOTER', 'WRETCH', 'SWAB'],
    ),
    PuzzleCategory(
      id: 'rogue-celtic2',
      label: 'Celtic rogues',
      etymology: 'Celtic words for people you\'d cross the street to avoid — a fool, a usurer, a babbler, and a nobody.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['ROASTER', 'GOMBEEN', 'BLETHER', 'NYAFF'],
    ),
  ],
);
