import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Goat Rope
const vulgus040 = Puzzle(
  id: 'VULGUS-040',
  categories: [
    PuzzleCategory(
      id: 'mil-acr',
      label: 'Military acronyms',
      etymology: 'WWII US military acronym: Situation Normal, All F***ed Up.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SNAFU', 'FUBAR', 'POGUE', 'TARFU'],
    ),
    PuzzleCategory(
      id: 'mil-mess',
      label: 'Military words for a mess',
      etymology: 'US military slang — a "goat rope" or "charlie foxtrot" is a chaotic operation; a "sad sack" is the unfortunate soul stuck in it.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['GOAT ROPE', 'CHARLIE FOXTROT', 'SAD SACK', 'CLUSTER'],
    ),
    PuzzleCategory(
      id: 'modern-fail',
      label: 'Modern slang',
      etymology: '1980s US hip-hop; \'bad, inferior\'.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['WACK', 'JANKY', 'BUSTED', 'CRUD'],
    ),
    PuzzleCategory(
      id: 'emo-state',
      label: 'Emotional-state slang',
      etymology: '2010s US internet slang; \'bitter or resentful\'. Earlier Navy slang too.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SALTY', 'SHOOK', 'TRIPPIN', 'DISS'],
    ),
  ],
);
