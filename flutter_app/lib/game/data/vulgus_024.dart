import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Great British Banter
const vulgus024 = Puzzle(
  id: 'VULGUS-024',
  categories: [
    PuzzleCategory(
      id: 'bant-y',
      label: 'Entry-level British',
      etymology: '1980s UK slang from Jim Henson\'s Muppets; gentle insult.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['MUPPET', 'WALLY', 'TWIT', 'NITWIT'],
    ),
    PuzzleCategory(
      id: 'bant-b',
      label: 'Mid-level British',
      etymology: 'Originally slang for penis (1940s); meaning \'fool\' from 1980s sitcoms.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['PLONKER', 'NUMPTY', 'PILLOCK', 'BUGGER'],
    ),
    PuzzleCategory(
      id: 'bant-r',
      label: 'Strong British',
      etymology: 'Old English \'beallucas\' (testicles); by the 1860s meant \'nonsense\'; Sex Pistols 1977.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['BOLLOCKS', 'ARSE', 'BERK', 'KNACKERS'],
    ),
    PuzzleCategory(
      id: 'bant-k',
      label: 'Shakespearean British',
      etymology: 'Medieval: a knight\'s attendant → rogue by 16th C.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['VARLET', 'KNAVE', 'RAPSCALLION', 'SCOUNDREL'],
    ),
  ],
);
