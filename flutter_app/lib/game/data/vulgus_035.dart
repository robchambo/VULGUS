import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// All Rot
const vulgus035 = Puzzle(
  id: 'VULGUS-035',
  categories: [
    PuzzleCategory(
      id: 'short-rot',
      label: 'Blunt rubbish',
      etymology: '19th C slang for rubbish; origin disputed.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['TOSH', 'HOGWASH', 'HOOEY', 'CRUD'],
    ),
    PuzzleCategory(
      id: 'vic-rot',
      label: 'Victorian rubbish',
      etymology: 'From Dutch \'pappekak\' — soft dung. Polite now, very rude in origin.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['POPPYCOCK', 'BALDERDASH', 'CODSWALLOP', 'CLAPTRAP'],
    ),
    PuzzleCategory(
      id: 'us-rot',
      label: 'American rubbish',
      etymology: '1920s US; origin disputed — possibly from Irish surname.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['MALARKEY', 'BALONEY', 'BUBKES', 'BUNKUM'],
    ),
    PuzzleCategory(
      id: 'frontier-rot',
      label: 'Frontier nonsense',
      etymology: 'Mid-19th C US; nonsense, drivel.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['FLAPDOODLE', 'HORNSWOGGLE', 'CATTYWAMPUS', 'COCKAMAMIE'],
    ),
  ],
);
