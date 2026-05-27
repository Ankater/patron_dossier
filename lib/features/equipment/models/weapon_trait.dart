class Trait {
  const Trait({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  Trait copyWith({
    int? id,
    String? name,
  }) =>
      Trait(
        id: id ?? this.id,
        name: name ?? this.name,
      );
}
