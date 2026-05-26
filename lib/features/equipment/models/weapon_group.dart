import 'weapon.dart';

class WeaponGroup {
  const WeaponGroup({
    required this.name,
    required this.weapons,
  });

  final String name;
  final List<Weapon> weapons;

  WeaponGroup copyWith({
    String? name,
    List<Weapon>? weapons,
  }) =>
      WeaponGroup(
        name: name ?? this.name,
        weapons: weapons ?? this.weapons,
      );
}
