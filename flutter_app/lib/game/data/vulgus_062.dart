import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Scatological Studies
const vulgus062 = Puzzle(
  id: 'VULGUS-062',
  categories: [
    PuzzleCategory(
      id: 'scat-mild',
      label: 'Mild filth words',
      etymology: 'The gentler end of the scatological spectrum — still rude, but grandma-adjacent.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['CRAP', 'CRUD', 'GUFF', 'DRECK'],
    ),
    PuzzleCategory(
      id: 'scat-food',
      label: 'Food-grade filth',
      etymology: 'Words that bridge food waste and verbal waste — organ meat, dribble, trifle, and odds and ends.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['TRIPE', 'DRIVEL', 'PIFFLE', 'GUBBINS'],
    ),
    PuzzleCategory(
      id: 'scat-nonsense',
      label: 'Scatological nonsense',
      etymology: 'Words for nonsense with surprisingly earthy etymologies.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['TWADDLE', 'CODSWALLOP', 'HOGWASH', 'BILGE'],
    ),
    PuzzleCategory(
      id: 'scat-hidden',
      label: 'Secretly scatological',
      etymology: 'Thomas Crapper the plumber, baby talk, nasal excavation, and a tramp\'s foot-wrapping.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CRAPPER', 'DOODOO', 'BOOGER', 'TOERAG'],
    ),
  ],
);
