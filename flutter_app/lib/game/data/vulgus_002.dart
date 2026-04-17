import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Taking the Lord's Name
const vulgus002 = Puzzle(
  id: 'VULGUS-002',
  categories: [
    PuzzleCategory(
      id: 'god-lite',
      label: 'Polite stand-ins for 'God'',
      etymology: 'Clipped form of \'Jesus\'; late 19th C US.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['GEE', 'GOSH', 'GOLLY', 'CRIPES'],
    ),
    PuzzleCategory(
      id: 'divine-med',
      label: 'Stronger divine oaths',
      etymology: 'From Old French \'damner\' → to condemn; softened to a general intensifier.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['DAMN', 'BEJESUS', 'HELLFIRE', 'FECKIN'],
    ),
    PuzzleCategory(
      id: 'us-oaths',
      label: 'American minced oaths',
      etymology: 'Minced form of \'Jesus\'; popularised 1920s US.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['JEEZ', 'JEEPERS', 'SAKES', 'CRIMINY'],
    ),
    PuzzleCategory(
      id: 'archaic-divine',
      label: 'Archaic divine oaths',
      etymology: 'Contraction of \'God\'s wounds\' — 16th C oath.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['ZOUNDS', 'EGAD', 'GADZOOKS', 'TARNATION'],
    ),
  ],
);
