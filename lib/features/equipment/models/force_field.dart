import 'weapon_availability.dart';

class ForceField {
  const ForceField({
    required this.name,
    required this.protection,
    required this.overload,
    required this.enc,
    required this.cost,
    required this.availability,
  });

  final String name;
  final String protection;
  final int overload;
  final int enc;
  final int cost;
  final Availability availability;

  ForceField copyWith({
    String? name,
    String? protection,
    int? overload,
    int? enc,
    int? cost,
    Availability? availability,
  }) =>
      ForceField(
        name: name ?? this.name,
        protection: protection ?? this.protection,
        overload: overload ?? this.overload,
        enc: enc ?? this.enc,
        cost: cost ?? this.cost,
        availability: availability ?? this.availability,
      );
}
