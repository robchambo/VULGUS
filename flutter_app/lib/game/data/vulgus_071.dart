import '../models/difficulty.dart';
import '../models/puzzle.dart';
import '../models/puzzle_category.dart';
import '../../theme/app_colors.dart';

// Anatomy Lesson
const vulgus071 = Puzzle(
  id: 'VULGUS-071',
  categories: [
    PuzzleCategory(
      id: 'anat-brit',
      label: 'British anatomy',
      etymology: 'British English body-part slang — the rear, the bottom, the rounded bit, and the head.',
      color: AppColors.secondaryContainer,
      difficulty: Difficulty.easy,
      tiles: ['ARSE', 'BUM', 'KNOB', 'BONCE'],
    ),
    PuzzleCategory(
      id: 'anat-cockney',
      label: 'Cockney anatomy',
      etymology: 'Cockney rhyming slang for anatomy and actions: Hampton Wick, Khyber Pass, cobbler\'s awls, raspberry tart.',
      color: AppColors.tertiary,
      difficulty: Difficulty.medium,
      tiles: ['HAMPTON', 'KHYBER', 'COBBLERS', 'RASPBERRY'],
    ),
    PuzzleCategory(
      id: 'anat-insult',
      label: 'Anatomy-based insults',
      etymology: 'When the insult IS the body part — or what you do with it.',
      color: AppColors.primary,
      difficulty: Difficulty.hard,
      tiles: ['KNACKERS', 'BOLLOCKS', 'TOSSER', 'WANKER'],
    ),
    PuzzleCategory(
      id: 'anat-hidden',
      label: 'Secretly anatomical',
      etymology: 'Words that originally referred to anatomy before settling into "idiot" — all four trace to body parts.',
      color: AppColors.onSurface,
      difficulty: Difficulty.trickiest,
      tiles: ['PILLOCK', 'SCHMUCK', 'PUTZ', 'DORK'],
    ),
  ],
);
