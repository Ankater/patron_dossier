import 'character_stats.dart';

class CharacterBlankObject {
  const CharacterBlankObject({
    this.stats = const CharacterStats(),
  });

  final CharacterStats stats;

  CharacterBlankObject copyWith({CharacterStats? stats}) =>
      CharacterBlankObject(stats: stats ?? this.stats);
}
