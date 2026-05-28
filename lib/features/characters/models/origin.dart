import '../../../features/equipment/models/character_gear.dart';
import 'characteristic.dart';

class Origin {
  const Origin({
    required this.name,
    required this.bonusCharacteristic,
    required this.bonusSelectCharacteristic,
    required this.characterGear,
    required this.source,
  });

  final String name;
  final Characteristic bonusCharacteristic;
  final List<Characteristic> bonusSelectCharacteristic;
  final CharacterGear characterGear;
  final String source;

  Origin copyWith({
    String? name,
    Characteristic? bonusCharacteristic,
    List<Characteristic>? bonusSelectCharacteristic,
    CharacterGear? characterGear,
    String? source,
  }) =>
      Origin(
        name: name ?? this.name,
        bonusCharacteristic: bonusCharacteristic ?? this.bonusCharacteristic,
        bonusSelectCharacteristic:
            bonusSelectCharacteristic ?? this.bonusSelectCharacteristic,
        characterGear: characterGear ?? this.characterGear,
        source: source ?? this.source,
      );
}
