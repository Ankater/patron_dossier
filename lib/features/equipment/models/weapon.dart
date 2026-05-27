import 'weapon_availability.dart';
import 'weapon_specialisation.dart';
import 'weapon_trait.dart';

const _unset = Object();

class Weapon {
  const Weapon({
    required this.id,
    required this.name,
    required this.specialisation,
    required this.damage,
    required this.enc,
    required this.cost,
    required this.availability,
    required this.source,
    required this.traits,
    this.range,
    this.mag,
  });

  final int id;
  final String name;
  final WeaponSpecialisation specialisation;
  final String damage;
  final String? range;
  final int? mag;
  final int enc;
  final int? cost;
  final Availability? availability;
  final String source;
  final List<Trait> traits;

  Weapon copyWith({
    int? id,
    String? name,
    WeaponSpecialisation? specialisation,
    String? damage,
    Object? range = _unset,
    Object? mag = _unset,
    int? enc,
    Object? cost = _unset,
    Object? availability = _unset,
    String? source,
    List<Trait>? traits,
  }) =>
      Weapon(
        id: id ?? this.id,
        name: name ?? this.name,
        specialisation: specialisation ?? this.specialisation,
        damage: damage ?? this.damage,
        range: range == _unset ? this.range : range as String?,
        mag: mag == _unset ? this.mag : mag as int?,
        enc: enc ?? this.enc,
        cost: cost == _unset ? this.cost : cost as int?,
        availability: availability == _unset
            ? this.availability
            : availability as Availability?,
        source: source ?? this.source,
        traits: traits ?? this.traits,
      );

  bool get isMelee {
    switch (specialisation) {
      case WeaponSpecialisation.oneHanded:
      case WeaponSpecialisation.twoHanded:
      case WeaponSpecialisation.brawling:
        return true;
      case WeaponSpecialisation.pistol:
      case WeaponSpecialisation.longGun:
      case WeaponSpecialisation.ordnance:
      case WeaponSpecialisation.thrown:
      case WeaponSpecialisation.thrownOrdnance:
      case WeaponSpecialisation.engineering:
        return false;
    }
  }
}
