enum WeaponSpecialisation {
  pistol,
  longGun,
  ordnance,
  thrown,
  thrownOrdnance,
  engineering,
  oneHanded,
  twoHanded,
  brawling,
}

extension WeaponSpecialisationDetails on WeaponSpecialisation {
  int get id {
    switch (this) {
      case WeaponSpecialisation.pistol:
        return 1;
      case WeaponSpecialisation.longGun:
        return 2;
      case WeaponSpecialisation.ordnance:
        return 3;
      case WeaponSpecialisation.thrown:
        return 4;
      case WeaponSpecialisation.thrownOrdnance:
        return 5;
      case WeaponSpecialisation.engineering:
        return 6;
      case WeaponSpecialisation.oneHanded:
        return 7;
      case WeaponSpecialisation.twoHanded:
        return 8;
      case WeaponSpecialisation.brawling:
        return 9;
    }
  }

  String get label {
    switch (this) {
      case WeaponSpecialisation.pistol:
        return 'Pistol';
      case WeaponSpecialisation.longGun:
        return 'Long Gun';
      case WeaponSpecialisation.ordnance:
        return 'Ordnance';
      case WeaponSpecialisation.thrown:
        return 'Thrown';
      case WeaponSpecialisation.thrownOrdnance:
        return 'Thrown, Ordnance';
      case WeaponSpecialisation.engineering:
        return 'Engineering';
      case WeaponSpecialisation.oneHanded:
        return 'One-handed';
      case WeaponSpecialisation.twoHanded:
        return 'Two-handed';
      case WeaponSpecialisation.brawling:
        return 'Brawling';
    }
  }
}
