import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// What a Mess
const vulgus043 = Puzzle(
  id: 'VULGUS-043',
  categories: [
    PuzzleCategory(
      id: 'mil-mess',
      label: 'Military-grade chaos',
      etymology: 'US military slang for operations that have gone sideways.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SNAFU', 'CLUSTER', 'GOAT ROPE', 'CHARLIE FOXTROT'],
    ),
    PuzzleCategory(
      id: 'people-mess',
      label: 'People in a mess',
      etymology: 'WWII cartoon by George Baker; \'a hapless loser\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SAD SACK', 'POGUE', 'PALOOKA', 'YAHOO'],
    ),
    PuzzleCategory(
      id: 'internet-fail',
      label: 'Internet-age slang',
      etymology: '1980s US hip-hop; \'bad, inferior\'.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['WACK', 'SHOOK', 'BUSTED', 'BOGUS'],
    ),
    PuzzleCategory(
      id: 'old-mess',
      label: 'Old-school chaos',
      etymology: 'Originally 16th C for a frothy drink; meaning \'nonsense\' by 17th C.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BALDERDASH', 'HOG-TIED', 'COCKAMAMIE', 'HORNSWOGGLE'],
    ),
  ],
);
