import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Down the Rabbit Hole
const vulgus006 = Puzzle(
  id: 'VULGUS-006',
  categories: [
    PuzzleCategory(
      id: 'scifi',
      label: 'Fictional TV swears',
      etymology: 'Battlestar Galactica (1978 / 2004) — invented profanity.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['FRAK', 'SMEG', 'FRELL', 'GORRAM'],
    ),
    PuzzleCategory(
      id: 'military',
      label: 'Military acronyms',
      etymology: 'WWII US military acronym: Situation Normal, All F***ed Up.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNAFU', 'FUBAR', 'BOHICA', 'TARFU'],
    ),
    PuzzleCategory(
      id: 'west',
      label: 'Old Western US expressions',
      etymology: 'Ozark/Southern US minced form of \'God damn it\'.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['DAGNABBIT', 'JIMINY', 'CONSARN', 'FIDDLE-FADDLE'],
    ),
    PuzzleCategory(
      id: 'obscure',
      label: '19th-century US curiosities',
      etymology: '19th C US — a shrewd, unprincipled politician.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['SNOLLYGOSTER', 'CATTYWAMPUS', 'HORSEFEATHERS', 'BUSHWA'],
    ),
  ],
);
