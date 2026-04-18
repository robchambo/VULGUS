import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Pirate's Life
const vulgus085 = Puzzle(
  id: 'VULGUS-085',
  categories: [
    PuzzleCategory(
      id: 'pirate-easy',
      label: 'Easy pirate words',
      etymology: 'The pirate basics — diseased, land-bound, mopping, and encrusted.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['SCURVY', 'LANDLUBBER', 'SWAB', 'BARNACLE'],
    ),
    PuzzleCategory(
      id: 'pirate-rogue',
      label: 'Pirate rogues',
      etymology: 'Words for sea-going scoundrels — from Caribbean meat-smokers to free-booting plunderers.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['BUCCANEER', 'FREEBOOTER', 'SCALLYWAG', 'RAPSCALLION'],
    ),
    PuzzleCategory(
      id: 'pirate-punish',
      label: 'Pirate punishments',
      etymology: 'Things pirates did to each other — dragged under the hull, sunk, and bilge-dwelling.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['KEELHAUL', 'SCUPPER', 'BILGE', 'BILGE RAT'],
    ),
    PuzzleCategory(
      id: 'pirate-cross',
      label: 'Pirate crossovers',
      etymology: 'Animal insults equally at home at sea or on land — strays, wretches, sneaks, and vermin.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['CUR', 'WRETCH', 'WEASEL', 'RAT'],
    ),
  ],
);
