class WeaponTrait {
  const WeaponTrait({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  WeaponTrait copyWith({
    int? id,
    String? name,
  }) =>
      WeaponTrait(
        id: id ?? this.id,
        name: name ?? this.name,
      );
}
