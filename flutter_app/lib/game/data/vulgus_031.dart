import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Holy Mackerel
const vulgus031 = Puzzle(
  id: 'VULGUS-031',
  categories: [
    PuzzleCategory(
      id: 'holy',
      label: '"Holy ___" surprises',
      etymology: 'American euphemisms for "holy sh*t" — religious taboo avoidance via animal/marine swap-ins.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['HOLY COW', 'HOLY MOLY', 'HOLY SMOKES', 'HOLY MACKEREL'],
    ),
    PuzzleCategory(
      id: 'minced-jesus',
      label: 'Minced "Jesus"',
      etymology: 'Clipped form of \'Jesus\'; late 19th C US.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GEE', 'GOLLY', 'JEEPERS', 'JIMINY'],
    ),
    PuzzleCategory(
      id: 'archaic-brit',
      label: 'Archaic British oaths',
      etymology: 'Euphemism for \'Oh God\'; 17th C.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['EGAD', 'ZOUNDS', 'GADZOOKS', 'CRIPES'],
    ),
    PuzzleCategory(
      id: 'southern-oaths',
      label: 'Southern US oaths',
      etymology: 'Ozark/Southern US minced form of \'God damn it\'.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['DAGNABBIT', 'TARNATION', 'CRIMINY', 'SAKES'],
    ),
  ],
);
