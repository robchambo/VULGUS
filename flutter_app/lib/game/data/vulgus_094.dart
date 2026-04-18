import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Full English
const vulgus094 = Puzzle(
  id: 'VULGUS-094',
  categories: [
    PuzzleCategory(
      id: 'fe-breakfast',
      label: 'Breakfast insults',
      etymology: 'Foods you might find at breakfast that are also insults — silly, attractive, bonkers, and a dud.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SAUSAGE', 'CRUMPET', 'BANANA', 'LEMON'],
    ),
    PuzzleCategory(
      id: 'fe-mild',
      label: 'Full English mild',
      etymology: 'Exclamations over the morning newspaper — surprise, shock, and mild disbelief.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['CRIKEY', 'BLIMEY', 'STREWTH', 'GOOD GRIEF'],
    ),
    PuzzleCategory(
      id: 'fe-insult',
      label: 'Full English insults',
      etymology: 'Words for the uncultured — commoners, boors, country folk, and clumsy lumps.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['PLEB', 'LOUT', 'YOKEL', 'OAFS'],
    ),
    PuzzleCategory(
      id: 'fe-strong',
      label: 'Full English strong',
      etymology: 'What actually gets said over the Full English — the four horsemen of British swearing.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['BLOODY', 'BUGGER', 'WANKER', 'BOLLOCKS'],
    ),
  ],
);
