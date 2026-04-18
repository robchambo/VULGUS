import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Lazy Bones
const vulgus064 = Puzzle(
  id: 'VULGUS-064',
  categories: [
    PuzzleCategory(
      id: 'lazy-brit',
      label: 'British laziness',
      etymology: 'British English has a rich vocabulary for avoiding work.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SLACKER', 'SKIVER', 'SHIRKER', 'DOSSER'],
    ),
    PuzzleCategory(
      id: 'lazy-work',
      label: 'Workplace wasters',
      etymology: 'The office, the street corner, and the black market — British words for the professionally idle.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['JOBSWORTH', 'LAYABOUT', 'SPIV', 'WASTREL'],
    ),
    PuzzleCategory(
      id: 'lazy-oz',
      label: 'Australian laziness',
      etymology: 'Australian words for those who won\'t pull their weight — or pull anything at all.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BLUDGER', 'LARRIKIN', 'YOBBO', 'DRONGO'],
    ),
    PuzzleCategory(
      id: 'lazy-hidden',
      label: 'Secretly about laziness',
      etymology: 'Words that conceal their lazy origins — a sponger, a stooping idler, a country bumpkin, and a crude bore.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['PONCE', 'LOUT', 'YOKEL', 'CRASS'],
    ),
  ],
);
