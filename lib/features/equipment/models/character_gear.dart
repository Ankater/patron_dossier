import 'gear.dart';
import 'gear_property.dart';
import 'weapon_availability.dart';

class CharacterGear extends Gear {
  const CharacterGear({
    required super.name,
    required super.enc,
    required super.cost,
    required super.availability,
    required super.group,
    required super.source,
    this.qualities = const [],
    this.flaws = const [],
  });

  final List<Quality> qualities;
  final List<Flaw> flaws;

  @override
  CharacterGear copyWith({
    String? name,
    int? enc,
    int? cost,
    Availability? availability,
    String? group,
    String? source,
    List<Quality>? qualities,
    List<Flaw>? flaws,
  }) =>
      CharacterGear(
        name: name ?? this.name,
        enc: enc ?? this.enc,
        cost: cost ?? this.cost,
        availability: availability ?? this.availability,
        group: group ?? this.group,
        source: source ?? this.source,
        qualities: qualities ?? this.qualities,
        flaws: flaws ?? this.flaws,
      );
}
