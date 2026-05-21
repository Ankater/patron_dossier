import 'character_blank_object.dart';

class CharacterBuilder {
  const CharacterBuilder({
    required this.character,
    this.assignCharPoints,
    this.exp = 0,
  });

  final CharacterBlankObject character;
  final int? assignCharPoints;
  final int exp;

  CharacterBuilder copyWith({
    CharacterBlankObject? character,
    int? assignCharPoints,
    int? exp,
  }) =>
      CharacterBuilder(
        character: character ?? this.character,
        assignCharPoints: assignCharPoints ?? this.assignCharPoints,
        exp: exp ?? this.exp,
      );
}
