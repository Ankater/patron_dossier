import 'package:flutter_test/flutter_test.dart';
import 'package:patron_dossier/features/equipment/models/armour.dart';
import 'package:patron_dossier/features/equipment/models/armour_group.dart';
import 'package:patron_dossier/features/equipment/models/augment.dart';
import 'package:patron_dossier/features/equipment/models/character_gear.dart';
import 'package:patron_dossier/features/equipment/models/force_field.dart';
import 'package:patron_dossier/features/equipment/models/gear.dart';
import 'package:patron_dossier/features/equipment/models/gear_property.dart';
import 'package:patron_dossier/features/equipment/models/location_armour.dart';
import 'package:patron_dossier/features/equipment/models/preset_armour_traits.dart';
import 'package:patron_dossier/features/equipment/models/preset_armours.dart';
import 'package:patron_dossier/features/equipment/models/preset_augments.dart';
import 'package:patron_dossier/features/equipment/models/preset_force_fields.dart';
import 'package:patron_dossier/features/equipment/models/preset_gear.dart';
import 'package:patron_dossier/features/equipment/models/preset_gear_properties.dart';
import 'package:patron_dossier/features/equipment/models/preset_grenades_and_explosives.dart';
import 'package:patron_dossier/features/equipment/models/preset_melee_weapons.dart';
import 'package:patron_dossier/features/equipment/models/preset_ranged_weapons.dart';
import 'package:patron_dossier/features/equipment/models/preset_weapon_traits.dart';
import 'package:patron_dossier/features/equipment/models/weapon.dart';
import 'package:patron_dossier/features/equipment/models/weapon_availability.dart';
import 'package:patron_dossier/features/equipment/models/weapon_group.dart';
import 'package:patron_dossier/features/equipment/models/weapon_specialisation.dart';
import 'package:patron_dossier/features/equipment/models/weapon_trait.dart';

void main() {
  group('WeaponAvailability', () {
    test('exposes stable ids and labels', () {
      expect(Availability.common.id, 1);
      expect(Availability.common.label, 'Common');
      expect(Availability.scarce.id, 2);
      expect(Availability.scarce.label, 'Scarce');
      expect(Availability.rare.id, 3);
      expect(Availability.rare.label, 'Rare');
      expect(Availability.exotic.id, 4);
      expect(Availability.exotic.label, 'Exotic');
      expect(Availability.veryRare.id, 5);
      expect(Availability.veryRare.label, 'Very Rare');
    });
  });

  group('WeaponSpecialisation', () {
    test('exposes stable ids and labels', () {
      expect(WeaponSpecialisation.pistol.id, 1);
      expect(WeaponSpecialisation.pistol.label, 'Pistol');
      expect(WeaponSpecialisation.longGun.id, 2);
      expect(WeaponSpecialisation.longGun.label, 'Long Gun');
      expect(WeaponSpecialisation.ordnance.id, 3);
      expect(WeaponSpecialisation.ordnance.label, 'Ordnance');
      expect(WeaponSpecialisation.thrown.id, 4);
      expect(WeaponSpecialisation.thrown.label, 'Thrown');
      expect(WeaponSpecialisation.thrownOrdnance.id, 5);
      expect(WeaponSpecialisation.thrownOrdnance.label, 'Thrown, Ordnance');
      expect(WeaponSpecialisation.engineering.id, 6);
      expect(WeaponSpecialisation.engineering.label, 'Engineering');
      expect(WeaponSpecialisation.oneHanded.id, 7);
      expect(WeaponSpecialisation.oneHanded.label, 'One-handed');
      expect(WeaponSpecialisation.twoHanded.id, 8);
      expect(WeaponSpecialisation.twoHanded.label, 'Two-handed');
      expect(WeaponSpecialisation.brawling.id, 9);
      expect(WeaponSpecialisation.brawling.label, 'Brawling');
    });
  });

  group('Weapon model', () {
    const trait = Trait(id: 1, name: 'Close');
    const weapon = Weapon(
      id: 1,
      name: 'Test Weapon',
      specialisation: WeaponSpecialisation.pistol,
      damage: '5',
      range: 'Medium',
      mag: 2,
      enc: 1,
      cost: 100,
      availability: Availability.common,
      source: 'core book',
      traits: [trait],
    );

    test('copyWith updates values and preserves unspecified values', () {
      final updated = weapon.copyWith(
        name: 'Updated Weapon',
        cost: 200,
        traits: const [Trait(id: 2, name: 'Loud')],
      );

      expect(updated.id, 1);
      expect(updated.name, 'Updated Weapon');
      expect(updated.range, 'Medium');
      expect(updated.mag, 2);
      expect(updated.cost, 200);
      expect(updated.traits.single.name, 'Loud');
    });

    test('copyWith can clear nullable range and mag', () {
      final updated = weapon.copyWith(range: null, mag: null);

      expect(updated.range, isNull);
      expect(updated.mag, isNull);
    });

    test('copyWith can clear nullable cost and availability', () {
      final updated = weapon.copyWith(cost: null, availability: null);

      expect(updated.cost, isNull);
      expect(updated.availability, isNull);
    });

    test('isMelee is true only for melee specialisations', () {
      final meleeSpecialisations = {
        WeaponSpecialisation.oneHanded,
        WeaponSpecialisation.twoHanded,
        WeaponSpecialisation.brawling,
      };

      for (final specialisation in WeaponSpecialisation.values) {
        final checkedWeapon = weapon.copyWith(specialisation: specialisation);
        expect(
          checkedWeapon.isMelee,
          meleeSpecialisations.contains(specialisation),
          reason: specialisation.label,
        );
      }
    });
  });

  group('WeaponTrait', () {
    test('copyWith updates name and preserves id', () {
      const trait = Trait(id: 1, name: 'Close');
      final updated = trait.copyWith(name: 'Loud');

      expect(updated.id, 1);
      expect(updated.name, 'Loud');
    });
  });

  group('WeaponGroup', () {
    test('copyWith updates weapons and preserves name', () {
      const group = WeaponGroup(
        name: 'Group',
        weapons: [
          Weapon(
            id: 1,
            name: 'Test Weapon',
            specialisation: WeaponSpecialisation.pistol,
            damage: '5',
            enc: 1,
            cost: 100,
            availability: Availability.common,
            source: 'core book',
            traits: [],
          ),
        ],
      );

      final updated = group.copyWith(weapons: const []);

      expect(updated.name, 'Group');
      expect(updated.weapons, isEmpty);
    });
  });

  group('LocationArmour', () {
    test('copyWith updates nullable values and preserves unspecified values',
        () {
      const locationArmour = LocationArmour(arms: 1, body: 2, legs: 3);
      final updated = locationArmour.copyWith(arms: null, head: 4);

      expect(updated.arms, isNull);
      expect(updated.body, 2);
      expect(updated.legs, 3);
      expect(updated.head, 4);
    });

    test('getArmourValue returns the first available location value', () {
      expect(
        const LocationArmour(arms: 1, body: 2).armourValue,
        1,
      );
      expect(
        const LocationArmour(body: 2, legs: 3).armourValue,
        2,
      );
      expect(const LocationArmour(legs: 3).armourValue, 3);
      expect(const LocationArmour(head: 4).armourValue, 4);
      expect(const LocationArmour().armourValue, isNull);
    });
  });

  group('Armour model', () {
    const armour = Armour(
      name: 'Test Armour',
      locationArmour: LocationArmour(body: 3),
      enc: 2,
      cost: 300,
      availability: Availability.rare,
      traits: [Trait(id: 40, name: 'Heavy (3)')],
    );

    test('copyWith updates values and preserves unspecified values', () {
      final updated = armour.copyWith(
        name: 'Updated Armour',
        cost: 400,
        traits: const [Trait(id: 3, name: 'Loud')],
      );

      expect(updated.name, 'Updated Armour');
      expect(updated.locationArmour?.body, 3);
      expect(updated.enc, 2);
      expect(updated.cost, 400);
      expect(updated.availability, Availability.rare);
      expect(updated.traits.single.name, 'Loud');
    });

    test('copyWith can clear nullable location armour', () {
      final updated = armour.copyWith(locationArmour: null);

      expect(updated.locationArmour, isNull);
    });
  });

  group('ArmourGroup', () {
    test('copyWith updates armours and preserves name', () {
      const group = ArmourGroup(
        name: 'Group',
        armours: [
          Armour(
            name: 'Test Armour',
            locationArmour: LocationArmour(body: 3),
            enc: 2,
            cost: 300,
            availability: Availability.rare,
            traits: [],
          ),
        ],
      );

      final updated = group.copyWith(armours: const []);

      expect(updated.name, 'Group');
      expect(updated.armours, isEmpty);
    });
  });

  group('Augment model', () {
    const augment = Augment(
      name: 'Test Augment',
      cost: 500,
      availability: Availability.rare,
      featureDescriptions: [
        'Improves a characteristic.',
        'Requires surgical installation.',
      ],
    );

    test('copyWith updates values and preserves unspecified values', () {
      final updated = augment.copyWith(
        name: 'Updated Augment',
        cost: 750,
        featureDescriptions: const ['Updated feature.'],
      );

      expect(updated.name, 'Updated Augment');
      expect(updated.cost, 750);
      expect(updated.availability, Availability.rare);
      expect(updated.featureDescriptions, ['Updated feature.']);
    });
  });

  group('AugmentReplacement model', () {
    const replacement = AugmentReplacement(
      name: 'Test Replacement',
      cost: 1000,
      availability: Availability.exotic,
      featureDescriptions: ['Replaces a body part.'],
      slot: Slot(name: 'Primary'),
      locationArmour: LocationArmour(arms: 2),
      bodySlot: BodySlot.arm,
    );

    test('copyWith updates replacement values and preserves inherited values',
        () {
      final updated = replacement.copyWith(
        slot: const Slot(name: 'Secondary'),
        bodySlot: BodySlot.eye,
      );

      expect(updated.name, 'Test Replacement');
      expect(updated.cost, 1000);
      expect(updated.availability, Availability.exotic);
      expect(updated.featureDescriptions, ['Replaces a body part.']);
      expect(updated.slot.name, 'Secondary');
      expect(updated.locationArmour?.arms, 2);
      expect(updated.bodySlot, BodySlot.eye);
    });

    test('copyWith can clear nullable location armour', () {
      final updated = replacement.copyWith(locationArmour: null);

      expect(updated.locationArmour, isNull);
    });
  });

  group('Preset augments', () {
    Augment augmentNamed(String name) =>
        presetAugments.firstWhere((augment) => augment.name == name);

    AugmentReplacement replacementNamed(String name) =>
        presetAugmeticReplacements
            .firstWhere((augment) => augment.name == name);

    test('contains grouped augment data', () {
      expect(presetAugmentGroups, [
        augmentGroupAugmeticReplacements,
        augmentGroupAugmetics,
      ]);
      expect(presetAugmeticReplacements, hasLength(6));
      expect(presetAugmetics, hasLength(9));
      expect(presetAugments, hasLength(15));
    });

    test('uses unique names', () {
      final names = presetAugments.map((augment) => augment.name).toSet();

      expect(names, hasLength(presetAugments.length));
    });

    test('stores Augmetic Arm replacement row and features', () {
      final augment = replacementNamed('Augmetic Arm');

      expect(augment.cost, 1000);
      expect(augment.availability, Availability.scarce);
      expect(augment.slot, augmeticArmSlot);
      expect(augment.locationArmour?.arms, 1);
      expect(augment.bodySlot, BodySlot.arm);
      expect(augment.featureDescriptions, hasLength(3));
      expect(
        augment.featureDescriptions.last,
        contains('Two-handed melee weapons'),
      );
    });

    test('stores Augmetic Heart replacement row without location armour', () {
      final augment = replacementNamed('Augmetic Heart');

      expect(augment.cost, 3000);
      expect(augment.availability, Availability.rare);
      expect(augment.slot, augmeticHeartSlot);
      expect(augment.locationArmour, isNull);
      expect(augment.bodySlot, BodySlot.heart);
      expect(augment.featureDescriptions.last, contains('Hard (-20)'));
    });

    test('stores Tracks/Wheels as leg replacement armour', () {
      final augment = replacementNamed('Augmetic Tracks/Wheels');

      expect(augment.cost, 1500);
      expect(augment.availability, Availability.scarce);
      expect(augment.slot, augmeticLegSlot);
      expect(augment.locationArmour?.legs, 1);
      expect(augment.bodySlot, BodySlot.legs);
      expect(augment.featureDescriptions, hasLength(3));
    });

    test('stores Augur Array row', () {
      final augment = augmentNamed('Augur Array');

      expect(augment.cost, 6000);
      expect(augment.availability, Availability.rare);
      expect(augment.featureDescriptions.first, contains('Auspex'));
      expect(augment.featureDescriptions.last, contains('+5 Perception'));
    });

    test('stores mechadendrite rows', () {
      final ballistic = augmentNamed('Ballistic Mechadendrite');
      final manipulator = augmentNamed('Manipulator Mechadendrite');
      final medicae = augmentNamed('Medicae Mechadendrite');
      final optical = augmentNamed('Optical Mechadendrite');
      final utility = augmentNamed('Utility Mechadendrite');

      expect(ballistic.cost, 2000);
      expect(ballistic.featureDescriptions.single, contains('Laspistol'));
      expect(manipulator.cost, 1400);
      expect(manipulator.featureDescriptions, hasLength(3));
      expect(medicae.cost, 1400);
      expect(medicae.featureDescriptions, hasLength(3));
      expect(optical.cost, 1200);
      expect(optical.featureDescriptions, hasLength(3));
      expect(utility.cost, 1000);
      expect(utility.featureDescriptions, hasLength(3));
    });

    test('stores Mind Impulse Unit and Vocal Implant rows', () {
      final mindImpulseUnit = augmentNamed('Mind Impulse Unit');
      final vocalImplant = augmentNamed('Vocal Implant');

      expect(mindImpulseUnit.cost, 10000);
      expect(mindImpulseUnit.featureDescriptions.single, contains('Tech'));
      expect(vocalImplant.cost, 400);
      expect(vocalImplant.featureDescriptions.single, contains('100 metres'));
    });
  });

  group('Preset armours', () {
    Armour armourNamed(String name) =>
        presetArmours.firstWhere((armour) => armour.name == name);

    test('contains grouped data from the armour table', () {
      expect(presetArmourGroups, hasLength(5));
      expect(presetArmours, hasLength(27));
      expect(presetArmourGroups.first.name, 'Basic');
      expect(presetArmourGroups.last.name, 'Power');
    });

    test('uses unique names', () {
      final names = presetArmours.map((armour) => armour.name).toSet();

      expect(names, hasLength(presetArmours.length));
    });

    test('all related traits are declared in the armour trait list', () {
      final traitIds = armourTraits.map((trait) => trait.id).toSet();

      for (final armour in presetArmours) {
        for (final trait in armour.traits) {
          expect(traitIds, contains(trait.id), reason: armour.name);
        }
      }
    });

    test('stores Robes/Light Leathers row', () {
      final armour = armourNamed('Robes/Light Leathers');

      expect(armour.locationArmour?.arms, 1);
      expect(armour.locationArmour?.body, 1);
      expect(armour.locationArmour?.legs, 1);
      expect(armour.locationArmour?.head, isNull);
      expect(armour.locationArmour?.armourValue, 1);
      expect(armour.enc, 1);
      expect(armour.cost, 10);
      expect(armour.availability, Availability.common);
      expect(armour.traits.map((trait) => trait.name), ['Subtle']);
    });

    test('stores shield rows without location armour', () {
      final combatShield = armourNamed('Combat Shield');
      final boardingShield = armourNamed('Boarding Shield');

      expect(combatShield.locationArmour, isNull);
      expect(combatShield.enc, 2);
      expect(combatShield.cost, 700);
      expect(combatShield.availability, Availability.common);
      expect(combatShield.traits.map((trait) => trait.name), ['Shield (2)']);
      expect(boardingShield.locationArmour, isNull);
      expect(boardingShield.enc, 4);
      expect(boardingShield.cost, 1400);
      expect(boardingShield.availability, Availability.rare);
      expect(boardingShield.traits.map((trait) => trait.name), ['Shield (4)']);
    });

    test('stores Astra Militarum Flak Armour row', () {
      final armour = armourNamed('Astra Militarum Flak Armour');

      expect(armour.locationArmour?.arms, 4);
      expect(armour.locationArmour?.body, 4);
      expect(armour.locationArmour?.legs, 4);
      expect(armour.locationArmour?.head, 4);
      expect(armour.enc, 4);
      expect(armour.cost, 1000);
      expect(armour.availability, Availability.rare);
      expect(armour.traits.map((trait) => trait.name), ['Loud']);
    });

    test('stores Mesh Gauntlets row with zero encumbrance', () {
      final armour = armourNamed('Mesh Gauntlets');

      expect(armour.locationArmour?.arms, 3);
      expect(armour.locationArmour?.armourValue, 3);
      expect(armour.enc, 0);
      expect(armour.cost, 600);
      expect(armour.availability, Availability.rare);
      expect(armour.traits, isEmpty);
    });

    test('stores Tempestus Carapace row', () {
      final armour = armourNamed('Tempestus Carapace');

      expect(armour.locationArmour?.armourValue, 6);
      expect(armour.enc, 5);
      expect(armour.cost, 4000);
      expect(armour.availability, Availability.exotic);
      expect(
        armour.traits.map((trait) => trait.name),
        [
          'Heavy (4)',
          'Loud',
        ],
      );
    });

    test('stores Power Armour row', () {
      final armour = armourNamed('Power Armour');

      expect(armour.locationArmour?.arms, 10);
      expect(armour.locationArmour?.body, 10);
      expect(armour.locationArmour?.legs, 10);
      expect(armour.locationArmour?.head, 10);
      expect(armour.enc, 9);
      expect(armour.cost, 1000000);
      expect(armour.availability, Availability.exotic);
      expect(armour.traits.map((trait) => trait.name), ['Loud']);
    });
  });

  group('ForceField model', () {
    const forceField = ForceField(
      name: 'Test Field',
      protection: '1d10',
      overload: 10,
      enc: 0,
      cost: 1000,
      availability: Availability.exotic,
    );

    test('copyWith updates values and preserves unspecified values', () {
      final updated = forceField.copyWith(
        name: 'Updated Field',
        protection: '2d10',
        cost: 6000,
      );

      expect(updated.name, 'Updated Field');
      expect(updated.protection, '2d10');
      expect(updated.overload, 10);
      expect(updated.enc, 0);
      expect(updated.cost, 6000);
      expect(updated.availability, Availability.exotic);
    });
  });

  group('Preset force fields', () {
    ForceField forceFieldNamed(String name) =>
        presetForceFields.firstWhere((forceField) => forceField.name == name);

    test('contains data from the force fields table', () {
      expect(presetForceFields, hasLength(2));
      expect(presetForceFields.map((forceField) => forceField.name), [
        'Refractor Field',
        'Conversion Field',
      ]);
    });

    test('stores Refractor Field row', () {
      final forceField = forceFieldNamed('Refractor Field');

      expect(forceField.protection, '1d10');
      expect(forceField.overload, 10);
      expect(forceField.enc, 0);
      expect(forceField.cost, 1000);
      expect(forceField.availability, Availability.exotic);
    });

    test('stores Conversion Field row', () {
      final forceField = forceFieldNamed('Conversion Field');

      expect(forceField.protection, '2d10');
      expect(forceField.overload, 20);
      expect(forceField.enc, 0);
      expect(forceField.cost, 6000);
      expect(forceField.availability, Availability.exotic);
    });
  });

  group('Gear model', () {
    const gear = Gear(
      name: 'Test Gear',
      enc: 1,
      cost: 100,
      availability: Availability.common,
      group: 'Tools',
      source: 'core book',
    );

    test('copyWith updates values and preserves unspecified values', () {
      final updated = gear.copyWith(
        name: 'Updated Gear',
        cost: 200,
        availability: Availability.rare,
      );

      expect(updated.name, 'Updated Gear');
      expect(updated.enc, 1);
      expect(updated.cost, 200);
      expect(updated.availability, Availability.rare);
      expect(updated.group, 'Tools');
      expect(updated.source, 'core book');
    });
  });

  group('Preset gear', () {
    Gear gearNamed(String name) =>
        presetGear.firstWhere((gear) => gear.name == name);

    test('contains grouped data from the gear tables', () {
      expect(presetGearGroups, [
        'Tools',
        'Clothing and Personal Gear',
      ]);
      expect(presetGear, hasLength(47));
      expect(
        presetGear.where((gear) => gear.group == gearGroupTools),
        hasLength(37),
      );
      expect(
        presetGear.where(
          (gear) => gear.group == gearGroupClothingAndPersonalGear,
        ),
        hasLength(10),
      );
    });

    test('uses unique names and core book source', () {
      final names = presetGear.map((gear) => gear.name).toSet();

      expect(names, hasLength(presetGear.length));
      expect(
        presetGear.every((gear) => gear.source == 'core book'),
        isTrue,
      );
    });

    test('stores Disguise Kit row with very rare availability', () {
      final gear = gearNamed('Disguise Kit');

      expect(gear.enc, 1);
      expect(gear.cost, 100);
      expect(gear.availability, Availability.veryRare);
      expect(gear.group, gearGroupTools);
    });

    test('stores Monotask Servo-Skull row', () {
      final gear = gearNamed('Monotask Servo-Skull');

      expect(gear.enc, 0);
      expect(gear.cost, 2000);
      expect(gear.availability, Availability.rare);
      expect(gear.group, gearGroupTools);
    });

    test('stores Survival Gear row', () {
      final gear = gearNamed('Survival Gear');

      expect(gear.enc, 3);
      expect(gear.cost, 50);
      expect(gear.availability, Availability.common);
      expect(gear.group, gearGroupClothingAndPersonalGear);
    });

    test('stores Void Suit row', () {
      final gear = gearNamed('Void Suit');

      expect(gear.enc, 2);
      expect(gear.cost, 2000);
      expect(gear.availability, Availability.scarce);
      expect(gear.group, gearGroupClothingAndPersonalGear);
    });
  });

  group('Preset ranged weapons', () {
    Weapon weaponNamed(String name) =>
        presetRangedWeapons.firstWhere((weapon) => weapon.name == name);

    test('contains grouped data from the ranged weapons tables', () {
      expect(presetRangedWeaponGroups, hasLength(8));
      expect(presetRangedWeapons, hasLength(31));
      expect(presetRangedWeaponGroups.first.name, 'Bolt Weapons');
      expect(presetRangedWeaponGroups.last.name, 'Specialised Ranged Weapons');
    });

    test('uses unique ids and core book source', () {
      final ids = presetRangedWeapons.map((weapon) => weapon.id).toSet();

      expect(ids, hasLength(presetRangedWeapons.length));
      expect(
        presetRangedWeapons.every((weapon) => weapon.source == 'core book'),
        isTrue,
      );
    });

    test('all related traits are declared in the trait list', () {
      final traitIds = weaponTraits.map((trait) => trait.id).toSet();

      for (final weapon in presetRangedWeapons) {
        for (final trait in weapon.traits) {
          expect(traitIds, contains(trait.id), reason: weapon.name);
        }
      }
    });

    test('stores Bolt Pistol row', () {
      final weapon = weaponNamed('Bolt Pistol');

      expect(weapon.specialisation, WeaponSpecialisation.pistol);
      expect(weapon.damage, '8');
      expect(weapon.range, 'Medium');
      expect(weapon.mag, 2);
      expect(weapon.enc, 1);
      expect(weapon.cost, 4000);
      expect(weapon.availability, Availability.scarce);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Burst',
          'Close',
          'Loud',
          'Penetrating (4)',
          'Spread',
        ],
      );
    });

    test('stores Lascannon row', () {
      final weapon = weaponNamed('Lascannon');

      expect(weapon.specialisation, WeaponSpecialisation.ordnance);
      expect(weapon.damage, '18');
      expect(weapon.range, 'Extreme');
      expect(weapon.mag, 5);
      expect(weapon.enc, 4);
      expect(weapon.cost, 8000);
      expect(weapon.availability, Availability.rare);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Heavy (10)',
          'Loud',
          'Penetrating (10)',
          'Two-handed',
        ],
      );
    });

    test('stores Plasma Gun row', () {
      final weapon = weaponNamed('Plasma Gun');

      expect(weapon.specialisation, WeaponSpecialisation.longGun);
      expect(weapon.damage, '10');
      expect(weapon.range, 'Long');
      expect(weapon.mag, 12);
      expect(weapon.cost, 8000);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Loud',
          'Penetrating (6)',
          'Supercharge (4)',
          'Two-handed',
          'Unstable',
        ],
      );
    });

    test('stores Heavy Stubber row', () {
      final weapon = weaponNamed('Heavy Stubber');

      expect(weapon.specialisation, WeaponSpecialisation.ordnance);
      expect(weapon.damage, '8');
      expect(weapon.range, 'Extreme');
      expect(weapon.mag, 8);
      expect(weapon.enc, 3);
      expect(weapon.cost, 2000);
      expect(weapon.availability, Availability.scarce);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Heavy (4)',
          'Loud',
          'Penetrating (3)',
          'Two-handed',
          'Rapid Fire (4)',
        ],
      );
    });

    test('stores Webber row', () {
      final weapon = weaponNamed('Webber');

      expect(weapon.specialisation, WeaponSpecialisation.longGun);
      expect(weapon.damage, '-');
      expect(weapon.range, 'Medium');
      expect(weapon.mag, 6);
      expect(weapon.enc, 1);
      expect(weapon.cost, 1500);
      expect(weapon.availability, Availability.rare);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Inflict (Restrained)',
          'Two-handed',
        ],
      );
    });
  });

  group('Preset grenades and explosives', () {
    Weapon weaponNamed(String name) =>
        presetGrenadesAndExplosives.firstWhere((weapon) => weapon.name == name);

    test('contains data from the grenades and explosives table', () {
      expect(presetGrenadeAndExplosiveGroups, hasLength(1));
      expect(presetGrenadesAndExplosives, hasLength(12));
      expect(presetGrenadeAndExplosiveGroups.single.name,
          'Grenades and Explosives');
    });

    test('uses core book source and no range or mag values', () {
      expect(
        presetGrenadesAndExplosives.every(
          (weapon) =>
              weapon.source == 'core book' &&
              weapon.range == null &&
              weapon.mag == null,
        ),
        isTrue,
      );
    });

    test('stores Fire Bomb row', () {
      final weapon = weaponNamed('Fire Bomb');

      expect(weapon.specialisation, WeaponSpecialisation.thrown);
      expect(weapon.damage, '-');
      expect(weapon.enc, 1);
      expect(weapon.cost, 10);
      expect(weapon.availability, Availability.common);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Blast',
          'Loud',
          'Inflict (Ablaze)',
          'Thrown (Medium)',
          'Unstable',
        ],
      );
    });

    test('stores Melta Bomb row', () {
      final weapon = weaponNamed('Melta Bomb');

      expect(weapon.specialisation, WeaponSpecialisation.engineering);
      expect(weapon.damage, '16');
      expect(weapon.enc, 2);
      expect(weapon.cost, 1000);
      expect(weapon.availability, Availability.exotic);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Rend (12)',
          'Spread',
          'Unstable',
        ],
      );
    });
  });

  group('Property model', () {
    const property = Property(name: 'Test Property', source: 'core book');

    test('copyWith updates name and preserves source', () {
      final updated = property.copyWith(name: 'Updated');

      expect(updated.name, 'Updated');
      expect(updated.source, 'core book');
    });

    test('copyWith updates source and preserves name', () {
      final updated = property.copyWith(source: 'supplement');

      expect(updated.name, 'Test Property');
      expect(updated.source, 'supplement');
    });
  });

  group('Quality model', () {
    const quality = Quality(name: 'Lightweight', source: 'core book');

    test('copyWith returns a Quality', () {
      final updated = quality.copyWith(name: 'Durable');

      expect(updated, isA<Quality>());
      expect(updated.name, 'Durable');
      expect(updated.source, 'core book');
    });
  });

  group('Flaw model', () {
    const flaw = Flaw(name: 'Bulky', source: 'core book');

    test('copyWith returns a Flaw', () {
      final updated = flaw.copyWith(name: 'Shoddy');

      expect(updated, isA<Flaw>());
      expect(updated.name, 'Shoddy');
      expect(updated.source, 'core book');
    });
  });

  group('Preset gear properties', () {
    test('presetQualities contains four named qualities', () {
      expect(presetQualities, hasLength(4));
      expect(
        presetQualities.map((q) => q.name),
        containsAll([
          'Lightweight',
          'Master Crafted',
          'Ornamental',
          'Durable',
        ]),
      );
      expect(
        presetQualities.every((q) => q.source == 'core book'),
        isTrue,
      );
    });

    test('presetFlaws contains four named flaws', () {
      expect(presetFlaws, hasLength(4));
      expect(
        presetFlaws.map((f) => f.name),
        containsAll([
          'Bulky',
          'Shoddy',
          'Ugly',
          'Unreliable',
        ]),
      );
      expect(
        presetFlaws.every((f) => f.source == 'core book'),
        isTrue,
      );
    });
  });

  group('CharacterGear model', () {
    const lightweight = Quality(name: 'Lightweight', source: 'core book');
    const bulky = Flaw(name: 'Bulky', source: 'core book');
    const characterGear = CharacterGear(
      name: 'Test Gear',
      enc: 1,
      cost: 100,
      availability: Availability.common,
      group: 'Tools',
      source: 'core book',
      qualities: [lightweight],
      flaws: [bulky],
    );

    test('defaults to empty qualities and flaws', () {
      const bare = CharacterGear(
        name: 'Bare Gear',
        enc: 0,
        cost: 50,
        availability: Availability.common,
        group: 'Tools',
        source: 'core book',
      );

      expect(bare.qualities, isEmpty);
      expect(bare.flaws, isEmpty);
    });

    test('copyWith updates qualities and preserves unspecified values', () {
      const durable = Quality(name: 'Durable', source: 'core book');
      final updated = characterGear.copyWith(qualities: [durable]);

      expect(updated.name, 'Test Gear');
      expect(updated.enc, 1);
      expect(updated.qualities.single.name, 'Durable');
      expect(updated.flaws.single.name, 'Bulky');
    });

    test('copyWith updates flaws and preserves unspecified values', () {
      const shoddy = Flaw(name: 'Shoddy', source: 'core book');
      final updated = characterGear.copyWith(flaws: [shoddy]);

      expect(updated.name, 'Test Gear');
      expect(updated.flaws.single.name, 'Shoddy');
      expect(updated.qualities.single.name, 'Lightweight');
    });

    test('copyWith returns a CharacterGear', () {
      final updated = characterGear.copyWith(name: 'Updated Gear');

      expect(updated, isA<CharacterGear>());
      expect(updated.name, 'Updated Gear');
    });

    test('is a subtype of Gear', () {
      expect(characterGear, isA<Gear>());
    });
  });

  group('Preset melee weapons', () {
    Weapon weaponNamed(String name) =>
        presetMeleeWeapons.firstWhere((weapon) => weapon.name == name);

    test('contains grouped data from the melee weapons table', () {
      expect(presetMeleeWeaponGroups, hasLength(5));
      expect(presetMeleeWeapons, hasLength(24));
      expect(presetMeleeWeaponGroups.first.name, 'Chain Weapons');
      expect(presetMeleeWeaponGroups.last.name, 'Power Weapons');
    });

    test('uses core book source and no range or mag values', () {
      expect(
        presetMeleeWeapons.every(
          (weapon) =>
              weapon.source == 'core book' &&
              weapon.range == null &&
              weapon.mag == null,
        ),
        isTrue,
      );
    });

    test('stores Eviscerator row', () {
      final weapon = weaponNamed('Eviscerator');

      expect(weapon.specialisation, WeaponSpecialisation.twoHanded);
      expect(weapon.damage, '5+StrB');
      expect(weapon.enc, 3);
      expect(weapon.cost, 800);
      expect(weapon.availability, Availability.rare);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Heavy (4)',
          'Loud',
          'Rend (4)',
          'Two-handed',
        ],
      );
    });

    test('stores dash cost and availability as null', () {
      final weapon = weaponNamed('Improvised (One-handed)');

      expect(weapon.cost, isNull);
      expect(weapon.availability, isNull);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Ineffective',
        ],
      );
    });

    test('stores Power Knife row', () {
      final weapon = weaponNamed('Power Knife');

      expect(weapon.specialisation, WeaponSpecialisation.oneHanded);
      expect(weapon.damage, '2+StrB');
      expect(weapon.enc, 1);
      expect(weapon.cost, 2000);
      expect(weapon.availability, Availability.rare);
      expect(
        weapon.traits.map((trait) => trait.name),
        [
          'Penetrating (2)',
          'Subtle',
          'Thrown (Short)',
        ],
      );
    });
  });
}
