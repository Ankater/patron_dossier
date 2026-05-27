import 'weapon_availability.dart';

class Gear {
  const Gear({
    required this.name,
    required this.enc,
    required this.cost,
    required this.availability,
    required this.group,
    required this.source,
  });

  final String name;
  final int enc;
  final int cost;
  final Availability availability;
  final String group;
  final String source;

  Gear copyWith({
    String? name,
    int? enc,
    int? cost,
    Availability? availability,
    String? group,
    String? source,
  }) =>
      Gear(
        name: name ?? this.name,
        enc: enc ?? this.enc,
        cost: cost ?? this.cost,
        availability: availability ?? this.availability,
        group: group ?? this.group,
        source: source ?? this.source,
      );
}
