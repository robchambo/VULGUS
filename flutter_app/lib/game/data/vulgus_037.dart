import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// What's in a Name?
const vulgus037 = Puzzle(
  id: 'VULGUS-037',
  categories: [
    PuzzleCategory(
      id: 'eponyms',
      label: 'Named after people/places',
      etymology: '"Bunkum" — Buncombe County NC; "Nimrod" — biblical hunter; "Crapper" — Thomas Crapper the plumber; "mountebank" — Italian "monta in banco" (climb on a bench).',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['BUNKUM', 'NIMROD', 'CRAPPER', 'MOUNTEBANK'],
    ),
    PuzzleCategory(
      id: 'scifi-coin',
      label: 'Coinages & inventions',
      etymology: 'Words coined or repurposed to fill the sweary gap — some from TV, one from good old English.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['FRAK', 'SMEG', 'CRUD', 'GORRAM'],
    ),
    PuzzleCategory(
      id: 'animal-insult',
      label: 'Animal-name insults',
      etymology: '"Galah" — a pink cockatoo; "turkey" — the country; "bogan" — possibly from Bogan River; "bogus" — origin obscure.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['GALAH', 'TURKEY', 'BOGAN', 'BOGUS'],
    ),
    PuzzleCategory(
      id: 'us-coin',
      label: 'American coinages',
      etymology: '19th – 20th C American English inventions of uncertain etymology.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNOLLYGOSTER', 'COCKAMAMIE', 'MALARKEY', 'BALONEY'],
    ),
  ],
);
