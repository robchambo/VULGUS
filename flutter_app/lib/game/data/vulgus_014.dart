import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Old West
const vulgus014 = Puzzle(
  id: 'VULGUS-014',
  categories: [
    PuzzleCategory(
      id: 'west-mild',
      label: 'Old Western mild exclamations',
      etymology: 'Ozark/Southern US minced form of \'God damn it\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DAGNABBIT', 'JIMINY', 'SAKES', 'CRIMINY'],
    ),
    PuzzleCategory(
      id: 'west-hard',
      label: 'Old Western strong words',
      etymology: '18th C US; blend of \'eternal\' and \'damnation\'.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['TARNATION', 'CONSARN', 'FIDDLE-FADDLE', 'CATTYWAMPUS'],
    ),
    PuzzleCategory(
      id: 'frontier',
      label: 'Frontier-era nonsense',
      etymology: '1920s US; coined by cartoonist Billy DeBeck as a minced euphemism.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['HORSEFEATHERS', 'BUSHWA', 'FLAPDOODLE', 'HORNSWOGGLE'],
    ),
    PuzzleCategory(
      id: 'frontier2',
      label: 'American pioneer slang',
      etymology: 'Mid-18th C; made famous by Dickens\' Scrooge.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['HUMBUG', 'BUNKUM', 'HOOEY', 'BALONEY'],
    ),
  ],
);
