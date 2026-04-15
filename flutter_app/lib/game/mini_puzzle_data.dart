import '../theme/app_colors.dart' show AppColors;
import 'models/puzzle_category.dart';
import 'models/puzzle_tile.dart';

final miniCategories = <PuzzleCategory>[
  const PuzzleCategory(
    id: 'minced',
    label: 'Minced oaths',
    etymology:
        'Substitutes that dodged the swear-jar. "Gosh", "blimey", "crikey" — '
        'softened versions invented to dance around taboo words.',
    color: AppColors.secondaryContainer,
    tiles: ['Gosh', 'Blimey', 'Crikey', 'Heck'],
  ),
  const PuzzleCategory(
    id: 'british',
    label: 'British classics',
    etymology:
        'Pub-tested, council-estate-approved British staples. From Old English '
        'rooted vulgarities to 19th-century slang that stuck.',
    color: AppColors.primary,
    tiles: ['Bollocks', 'Knackered', 'Naff', 'Gobsmacked'],
  ),
];

List<PuzzleTile> miniTiles() => [
      for (final c in miniCategories)
        for (final w in c.tiles) PuzzleTile(word: w, categoryId: c.id),
    ];
