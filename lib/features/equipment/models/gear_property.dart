class Property {
  const Property({required this.name, required this.source});

  final String name;
  final String source;

  Property copyWith({String? name, String? source}) => Property(
        name: name ?? this.name,
        source: source ?? this.source,
      );
}

class Quality extends Property {
  const Quality({required super.name, required super.source});

  @override
  Quality copyWith({String? name, String? source}) => Quality(
        name: name ?? this.name,
        source: source ?? this.source,
      );
}

class Flaw extends Property {
  const Flaw({required super.name, required super.source});

  @override
  Flaw copyWith({String? name, String? source}) => Flaw(
        name: name ?? this.name,
        source: source ?? this.source,
      );
}
