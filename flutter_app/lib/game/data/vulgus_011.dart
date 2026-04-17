import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Wobbly on Your Feet
const vulgus011 = Puzzle(
  id: 'VULGUS-011',
  categories: [
    PuzzleCategory(
      id: 'brit-tipsy',
      label: 'Politely drunk (British)',
      etymology: 'Dates to 14th C Middle English — probably onomatopoeic.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BUM', 'BLIMEY', 'SHUCKS', 'CRIKEY'],
    ),
    PuzzleCategory(
      id: 'nonsense2',
      label: 'More words for nonsense',
      etymology: 'Originally slop fed to pigs; figurative by 18th C.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['HOGWASH', 'HOOEY', 'CODSWALLOP', 'TOSH'],
    ),
    PuzzleCategory(
      id: 'us-slang2',
      label: 'Modern US slang',
      etymology: '1790s US counterfeit coins; \'fake, bad\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BOGUS', 'WACK', 'BUSTED', 'JANKY'],
    ),
    PuzzleCategory(
      id: 'us-archaic',
      label: 'Archaic US nonsense',
      etymology: '1920s US; coined by cartoonist Billy DeBeck as a minced euphemism.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['HORSEFEATHERS', 'FIDDLE-FADDLE', 'FLAPDOODLE', 'HORNSWOGGLE'],
    ),
  ],
);
