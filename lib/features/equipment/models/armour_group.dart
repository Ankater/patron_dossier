import 'armour.dart';

class ArmourGroup {
  const ArmourGroup({
    required this.name,
    required this.armours,
  });

  final String name;
  final List<Armour> armours;

  ArmourGroup copyWith({
    String? name,
    List<Armour>? armours,
  }) =>
      ArmourGroup(
        name: name ?? this.name,
        armours: armours ?? this.armours,
      );
}
