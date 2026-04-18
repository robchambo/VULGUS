import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Hissing Contempt
const vulgus079 = Puzzle(
  id: 'VULGUS-079',
  categories: [
    PuzzleCategory(
      id: 'hiss-s',
      label: 'S-words of contempt',
      etymology: 'Sibilant insults — the hissing S making each one sound extra contemptuous.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SNAKE', 'STINKER', 'SCOUNDREL', 'SHIRKER'],
    ),
    PuzzleCategory(
      id: 'hiss-sc',
      label: 'Sc-words of contempt',
      etymology: 'The SC- opening adds a scraping, scratching quality to already unpleasant words.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['SCURVY', 'SCALLYWAG', 'SCUT', 'SCUPPER'],
    ),
    PuzzleCategory(
      id: 'hiss-soft',
      label: 'Soft hissing',
      etymology: 'Quieter sibilants — a mop, a black-marketeer, a dodger, and a sulk.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['SWAB', 'SPIV', 'SKIVER', 'SNIT'],
    ),
    PuzzleCategory(
      id: 'hiss-hidden',
      label: 'Secret hissers',
      etymology: 'The S-word hall of fame — a medieval harlot, a 19th C politician, a Yiddish anatomical term, and a military acronym.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['STRUMPET', 'SNOLLYGOSTER', 'SCHMUCK', 'SNAFU'],
    ),
  ],
);
