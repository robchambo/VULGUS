import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Grand Finale II
const vulgus050 = Puzzle(
  id: 'VULGUS-050',
  categories: [
    PuzzleCategory(
      id: 'classics',
      label: 'British classics',
      etymology: 'Likely from \'by our Lady\'; disputed. Mild UK intensifier.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BLOODY', 'BLIMEY', 'ARSE', 'BUGGER'],
    ),
    PuzzleCategory(
      id: 'us-classics',
      label: 'American classics',
      etymology: 'From Old French \'damner\' → to condemn; softened to a general intensifier.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DAMN', 'HECK', 'CRAP', 'DANG'],
    ),
    PuzzleCategory(
      id: 'phrase-classics',
      label: 'Full-phrase swears',
      etymology: 'Multi-word American idioms that each stand in for something shorter and sharper.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['HOLY MACKEREL', 'SON OF A GUN', 'BLESS YOUR HEART', 'GOAT ROPE'],
    ),
    PuzzleCategory(
      id: 'archaic',
      label: 'The archaics',
      etymology: 'Contraction of \'God\'s wounds\' — 16th C oath.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['ZOUNDS', 'VARLET', 'SNOLLYGOSTER', 'BUSHWA'],
    ),
  ],
);
