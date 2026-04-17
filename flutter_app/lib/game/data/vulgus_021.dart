import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Southern Gothic
const vulgus021 = Puzzle(
  id: 'VULGUS-021',
  categories: [
    PuzzleCategory(
      id: 'south-mild',
      label: 'Southern US mild words',
      etymology: 'Ozark/Southern US minced form of \'God damn it\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DAGNABBIT', 'SAKES', 'CRIMINY', 'JIMINY'],
    ),
    PuzzleCategory(
      id: 'south-hard',
      label: 'Southern US strong words',
      etymology: '18th C US; blend of \'eternal\' and \'damnation\'.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['TARNATION', 'CONSARN', 'CATTYWAMPUS', 'FIDDLE-FADDLE'],
    ),
    PuzzleCategory(
      id: 'south-non',
      label: 'Southern nonsense words',
      etymology: '1920s US; coined by cartoonist Billy DeBeck as a minced euphemism.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['HORSEFEATHERS', 'BUSHWA', 'FLAPDOODLE', 'HORNSWOGGLE'],
    ),
    PuzzleCategory(
      id: 'south-sl',
      label: 'Southern slang for fool',
      etymology: 'Late 19th C US; popularised by Archie Bunker (\'All in the Family\').',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DINGBAT', 'DIPSTICK', 'PALOOKA', 'LUNKHEAD'],
    ),
  ],
);
