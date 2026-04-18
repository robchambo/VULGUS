import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Grand Finale III
const vulgus100 = Puzzle(
  id: 'VULGUS-100',
  categories: [
    PuzzleCategory(
      id: 'gf-brit',
      label: 'British hall of fame',
      etymology: 'The four pillars of British expression — an intensifier, nonsense, a fool, and surprise.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BLOODY', 'BOLLOCKS', 'MUPPET', 'CRIKEY'],
    ),
    PuzzleCategory(
      id: 'gf-world',
      label: 'World hall of fame',
      etymology: 'A fool from every corner — Irish, Australian, Yiddish, and American.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['EEJIT', 'DRONGO', 'SCHMUCK', 'DOOFUS'],
    ),
    PuzzleCategory(
      id: 'gf-arch',
      label: 'Archaic hall of fame',
      etymology: 'The archaics that deserve to live forever — an oath, nonsense, an ape-man, and a coward.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['ZOUNDS', 'BALDERDASH', 'JACKANAPES', 'POLTROON'],
    ),
    PuzzleCategory(
      id: 'gf-new',
      label: 'New additions hall of fame',
      etymology: 'The best words from the expanded dictionary — a fat slob, broken, dragged under the hull, and a street urchin.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['FUSTILUGS', 'BANJAXED', 'KEELHAUL', 'GUTTERSNIPE'],
    ),
  ],
);
