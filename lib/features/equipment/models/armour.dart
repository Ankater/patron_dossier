import 'location_armour.dart';
import 'weapon_availability.dart';
import 'weapon_trait.dart';

const _unset = Object();

class Armour {
  const Armour({
    required this.name,
    required this.locationArmour,
    required this.enc,
    required this.cost,
    required this.availability,
    required this.traits,
  });

  final String name;
  final LocationArmour? locationArmour;
  final int enc;
  final int cost;
  final Availability availability;
  final List<Trait> traits;

  Armour copyWith({
    String? name,
    Object? locationArmour = _unset,
    int? enc,
    int? cost,
    Availability? availability,
    List<Trait>? traits,
  }) =>
      Armour(
        name: name ?? this.name,
        locationArmour: locationArmour == _unset
            ? this.locationArmour
            : locationArmour as LocationArmour?,
        enc: enc ?? this.enc,
        cost: cost ?? this.cost,
        availability: availability ?? this.availability,
        traits: traits ?? this.traits,
      );
}
