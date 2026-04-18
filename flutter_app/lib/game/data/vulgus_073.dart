import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Ruddy Hell
const vulgus073 = Puzzle(
  id: 'VULGUS-073',
  categories: [
    PuzzleCategory(
      id: 'mild-intensify',
      label: 'Mild intensifiers',
      etymology: 'British substitute intensifiers — each standing in for something much stronger.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['RUDDY', 'BLOOMING', 'FLIPPING', 'BLASTED'],
    ),
    PuzzleCategory(
      id: 'strong-intensify',
      label: 'Strong intensifiers',
      etymology: 'The real thing — intensifiers that actually pack a punch.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BLOODY', 'DAMN', 'WICKED', 'FECKIN'],
    ),
    PuzzleCategory(
      id: 'exclam-mild',
      label: 'Mild exclamations',
      etymology: 'Exclamations of surprise from the gentler end of the spectrum.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['CRUMBS', 'STREWTH', 'PHOOEY', 'SNIT'],
    ),
    PuzzleCategory(
      id: 'exclam-strong',
      label: 'Strong exclamations',
      etymology: 'When crumbs won\'t cut it — from American holy-somethings to archaic British oaths.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['HOLY TOLEDO', 'BEJESUS', 'SAKES', 'EGAD'],
    ),
  ],
);
