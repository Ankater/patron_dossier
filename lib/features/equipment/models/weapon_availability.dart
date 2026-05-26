enum WeaponAvailability {
  common,
  scarce,
  rare,
  exotic,
}

extension WeaponAvailabilityDetails on WeaponAvailability {
  int get id {
    switch (this) {
      case WeaponAvailability.common:
        return 1;
      case WeaponAvailability.scarce:
        return 2;
      case WeaponAvailability.rare:
        return 3;
      case WeaponAvailability.exotic:
        return 4;
    }
  }

  String get label {
    switch (this) {
      case WeaponAvailability.common:
        return 'Common';
      case WeaponAvailability.scarce:
        return 'Scarce';
      case WeaponAvailability.rare:
        return 'Rare';
      case WeaponAvailability.exotic:
        return 'Exotic';
    }
  }
}
