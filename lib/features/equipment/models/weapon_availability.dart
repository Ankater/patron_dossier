enum Availability {
  common,
  scarce,
  rare,
  exotic,
  veryRare,
}

extension AvailabilityDetails on Availability {
  int get id {
    switch (this) {
      case Availability.common:
        return 1;
      case Availability.scarce:
        return 2;
      case Availability.rare:
        return 3;
      case Availability.exotic:
        return 4;
      case Availability.veryRare:
        return 5;
    }
  }

  String get label {
    switch (this) {
      case Availability.common:
        return 'Common';
      case Availability.scarce:
        return 'Scarce';
      case Availability.rare:
        return 'Rare';
      case Availability.exotic:
        return 'Exotic';
      case Availability.veryRare:
        return 'Very Rare';
    }
  }
}
