import 'location_armour.dart';
import 'weapon_availability.dart';

const _unset = Object();

class Slot {
  const Slot({
    required this.name,
  });

  final String name;

  Slot copyWith({
    String? name,
  }) =>
      Slot(
        name: name ?? this.name,
      );
}

enum BodySlot {
  arm,
  heart,
  legs,
  lungs,
  eye,
}

class Augment {
  const Augment({
    required this.name,
    required this.cost,
    required this.availability,
    required this.featureDescriptions,
  });

  final String name;
  final int cost;
  final Availability availability;
  final List<String> featureDescriptions;

  Augment copyWith({
    String? name,
    int? cost,
    Availability? availability,
    List<String>? featureDescriptions,
  }) =>
      Augment(
        name: name ?? this.name,
        cost: cost ?? this.cost,
        availability: availability ?? this.availability,
        featureDescriptions: featureDescriptions ?? this.featureDescriptions,
      );
}

class AugmentReplacement extends Augment {
  const AugmentReplacement({
    required super.name,
    required super.cost,
    required super.availability,
    required super.featureDescriptions,
    required this.slot,
    required this.bodySlot,
    this.locationArmour,
  });

  final Slot slot;
  final LocationArmour? locationArmour;
  final BodySlot bodySlot;

  @override
  AugmentReplacement copyWith({
    String? name,
    int? cost,
    Availability? availability,
    List<String>? featureDescriptions,
    Slot? slot,
    Object? locationArmour = _unset,
    BodySlot? bodySlot,
  }) =>
      AugmentReplacement(
        name: name ?? this.name,
        cost: cost ?? this.cost,
        availability: availability ?? this.availability,
        featureDescriptions: featureDescriptions ?? this.featureDescriptions,
        slot: slot ?? this.slot,
        locationArmour: locationArmour == _unset
            ? this.locationArmour
            : locationArmour as LocationArmour?,
        bodySlot: bodySlot ?? this.bodySlot,
      );
}
