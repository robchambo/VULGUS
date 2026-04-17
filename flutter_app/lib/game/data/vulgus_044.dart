import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// The Swerve
const vulgus044 = Puzzle(
  id: 'VULGUS-044',
  categories: [
    PuzzleCategory(
      id: 'gen-z',
      label: 'Gen-Z disapproval',
      etymology: '1980s US hip-hop; \'bad, inferior\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['WACK', 'JANKY', 'SALTY', 'SHOOK'],
    ),
    PuzzleCategory(
      id: 'internet',
      label: 'Internet-era verbs',
      etymology: '1960s US drug slang → 1990s hip-hop; \'acting irrationally\'.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['TRIPPIN', 'DISS', 'BUSTED', 'BOGUS'],
    ),
    PuzzleCategory(
      id: 'regional',
      label: 'Regional curios',
      etymology: 'Distinct regional US speech markers — Midwest "ope," Southern "reckon," Bostonian "wicked," Western "hog-tied."',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['OPE', 'RECKON', 'WICKED', 'HOG-TIED'],
    ),
    PuzzleCategory(
      id: 'us-phrases',
      label: 'US exclamation phrases',
      etymology: 'Full-phrase American mild swears — rhyming, quasi-religious, or just long enough to be safe.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['GEEZ LOUISE', 'SON OF A GUN', 'FOR PETE\'S SAKE', 'I\'LL BE'],
    ),
  ],
);
