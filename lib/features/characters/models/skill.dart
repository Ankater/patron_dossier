import 'characteristic.dart';

class Skill {
  const Skill({
    required this.name,
    required this.characteristic,
    this.specialisations = const [],
  });

  final String name;
  final Characteristic characteristic;
  final List<String> specialisations;

  Skill copyWith({
    String? name,
    Characteristic? characteristic,
    List<String>? specialisations,
  }) =>
      Skill(
        name: name ?? this.name,
        characteristic: characteristic ?? this.characteristic,
        specialisations: specialisations ?? this.specialisations,
      );
}

class CharacterSkill extends Skill {
  const CharacterSkill({
    required super.name,
    required super.characteristic,
    super.specialisations,
    this.advances = 0,
  }) : assert(advances >= 0, 'advances must be at least 0');

  final int advances;

  @override
  CharacterSkill copyWith({
    String? name,
    Characteristic? characteristic,
    List<String>? specialisations,
    int? advances,
  }) =>
      CharacterSkill(
        name: name ?? this.name,
        characteristic: characteristic ?? this.characteristic,
        specialisations: specialisations ?? this.specialisations,
        advances: advances ?? this.advances,
      );
}

class CharacterSkillSpecialisation {
  const CharacterSkillSpecialisation({
    required this.name,
    required this.skill,
    this.advances = 0,
  }) : assert(advances >= 0, 'advances must be at least 0');

  final String name;
  final Skill skill;
  final int advances;

  CharacterSkillSpecialisation copyWith({
    String? name,
    Skill? skill,
    int? advances,
  }) =>
      CharacterSkillSpecialisation(
        name: name ?? this.name,
        skill: skill ?? this.skill,
        advances: advances ?? this.advances,
      );
}
