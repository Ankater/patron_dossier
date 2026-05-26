import 'preset_weapon_traits.dart';
import 'weapon.dart';
import 'weapon_availability.dart';
import 'weapon_group.dart';
import 'weapon_specialisation.dart';

const chainWeapons = WeaponGroup(
  name: 'Chain Weapons',
  weapons: [
    Weapon(
      id: 44,
      name: 'Chainaxe',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '3+StrB',
      enc: 1,
      cost: 600,
      availability: WeaponAvailability.rare,
      source: 'core book',
      traits: [
        weaponTraitLoud,
        weaponTraitRend3,
      ],
    ),
    Weapon(
      id: 45,
      name: 'Chainsword',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '3+StrB',
      enc: 1,
      cost: 500,
      availability: WeaponAvailability.scarce,
      source: 'core book',
      traits: [
        weaponTraitLoud,
        weaponTraitRend2,
      ],
    ),
    Weapon(
      id: 46,
      name: 'Eviscerator',
      specialisation: WeaponSpecialisation.twoHanded,
      damage: '5+StrB',
      enc: 3,
      cost: 800,
      availability: WeaponAvailability.rare,
      source: 'core book',
      traits: [
        weaponTraitHeavy4,
        weaponTraitLoud,
        weaponTraitRend4,
        weaponTraitTwoHanded,
      ],
    ),
  ],
);

const forceWeapons = WeaponGroup(
  name: 'Force Weapons',
  weapons: [
    Weapon(
      id: 47,
      name: 'Force Staff',
      specialisation: WeaponSpecialisation.twoHanded,
      damage: '1+StrB',
      enc: 2,
      cost: 7000,
      availability: WeaponAvailability.exotic,
      source: 'core book',
      traits: [
        weaponTraitDefensive,
        weaponTraitTwoHanded,
      ],
    ),
    Weapon(
      id: 48,
      name: 'Force Sword',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '2+StrB',
      enc: 1,
      cost: 8000,
      availability: WeaponAvailability.exotic,
      source: 'core book',
      traits: [],
    ),
  ],
);

const mundaneWeapons = WeaponGroup(
  name: 'Mundane Weapons',
  weapons: [
    Weapon(
      id: 49,
      name: 'Axe',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '2+StrB',
      enc: 1,
      cost: 80,
      availability: WeaponAvailability.common,
      source: 'core book',
      traits: [],
    ),
    Weapon(
      id: 50,
      name: 'Brass Knuckles',
      specialisation: WeaponSpecialisation.brawling,
      damage: '0+StrB',
      enc: 0,
      cost: 30,
      availability: WeaponAvailability.common,
      source: 'core book',
      traits: [
        weaponTraitSubtle,
      ],
    ),
    Weapon(
      id: 51,
      name: 'Flail',
      specialisation: WeaponSpecialisation.twoHanded,
      damage: '4+StrB',
      enc: 2,
      cost: 200,
      availability: WeaponAvailability.common,
      source: 'core book',
      traits: [
        weaponTraitHeavy4,
        weaponTraitTwoHanded,
      ],
    ),
    Weapon(
      id: 52,
      name: 'Great Weapon',
      specialisation: WeaponSpecialisation.twoHanded,
      damage: '4+StrB',
      enc: 2,
      cost: 300,
      availability: WeaponAvailability.scarce,
      source: 'core book',
      traits: [
        weaponTraitHeavy4,
        weaponTraitTwoHanded,
      ],
    ),
    Weapon(
      id: 53,
      name: 'Hammer',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '2+StrB',
      enc: 1,
      cost: 25,
      availability: WeaponAvailability.common,
      source: 'core book',
      traits: [],
    ),
    Weapon(
      id: 54,
      name: 'Improvised (One-handed)',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '1+StrB',
      enc: 1,
      cost: null,
      availability: null,
      source: 'core book',
      traits: [
        weaponTraitIneffective,
      ],
    ),
    Weapon(
      id: 55,
      name: 'Improvised (Two-handed)',
      specialisation: WeaponSpecialisation.twoHanded,
      damage: '2+StrB',
      enc: 3,
      cost: null,
      availability: null,
      source: 'core book',
      traits: [
        weaponTraitIneffective,
        weaponTraitTwoHanded,
      ],
    ),
    Weapon(
      id: 56,
      name: 'Knife',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '0+StrB',
      enc: 0,
      cost: 50,
      availability: WeaponAvailability.common,
      source: 'core book',
      traits: [
        weaponTraitSubtle,
        weaponTraitThrownShort,
      ],
    ),
    Weapon(
      id: 57,
      name: 'Staff',
      specialisation: WeaponSpecialisation.twoHanded,
      damage: '1+StrB',
      enc: 2,
      cost: 25,
      availability: WeaponAvailability.common,
      source: 'core book',
      traits: [
        weaponTraitDefensive,
        weaponTraitTwoHanded,
      ],
    ),
    Weapon(
      id: 58,
      name: 'Sword',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '2+StrB',
      enc: 1,
      cost: 150,
      availability: WeaponAvailability.common,
      source: 'core book',
      traits: [],
    ),
    Weapon(
      id: 59,
      name: 'Unarmed',
      specialisation: WeaponSpecialisation.brawling,
      damage: '0+StrB',
      enc: 0,
      cost: null,
      availability: null,
      source: 'core book',
      traits: [
        weaponTraitIneffective,
      ],
    ),
    Weapon(
      id: 60,
      name: 'Whip',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '0+StrB',
      enc: 1,
      cost: 60,
      availability: WeaponAvailability.scarce,
      source: 'core book',
      traits: [
        weaponTraitLoud,
        weaponTraitReach,
      ],
    ),
  ],
);

const shockWeapons = WeaponGroup(
  name: 'Shock Weapons',
  weapons: [
    Weapon(
      id: 61,
      name: 'Electro-Flail',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '0+StrB',
      enc: 1,
      cost: 500,
      availability: WeaponAvailability.scarce,
      source: 'core book',
      traits: [
        weaponTraitLoud,
        weaponTraitReach,
        weaponTraitInflictStunned,
      ],
    ),
    Weapon(
      id: 62,
      name: 'Shock Maul',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '2+StrB',
      enc: 1,
      cost: 250,
      availability: WeaponAvailability.scarce,
      source: 'core book',
      traits: [
        weaponTraitLoud,
        weaponTraitInflictStunned,
      ],
    ),
  ],
);

const powerWeapons = WeaponGroup(
  name: 'Power Weapons',
  weapons: [
    Weapon(
      id: 63,
      name: 'Power Axe',
      specialisation: WeaponSpecialisation.twoHanded,
      damage: '6+StrB',
      enc: 2,
      cost: 3400,
      availability: WeaponAvailability.rare,
      source: 'core book',
      traits: [
        weaponTraitHeavy4,
        weaponTraitPenetrating6,
        weaponTraitTwoHanded,
      ],
    ),
    Weapon(
      id: 64,
      name: 'Power Fist',
      specialisation: WeaponSpecialisation.brawling,
      damage: '6+StrB',
      enc: 2,
      cost: 400,
      availability: WeaponAvailability.rare,
      source: 'core book',
      traits: [
        weaponTraitHeavy4,
        weaponTraitPenetrating6,
      ],
    ),
    Weapon(
      id: 65,
      name: 'Power Knife',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '2+StrB',
      enc: 1,
      cost: 2000,
      availability: WeaponAvailability.rare,
      source: 'core book',
      traits: [
        weaponTraitPenetrating2,
        weaponTraitSubtle,
        weaponTraitThrownShort,
      ],
    ),
    Weapon(
      id: 66,
      name: 'Power Maul',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '5+StrB',
      enc: 1,
      cost: 3000,
      availability: WeaponAvailability.rare,
      source: 'core book',
      traits: [
        weaponTraitPenetrating2,
      ],
    ),
    Weapon(
      id: 67,
      name: 'Power Sword',
      specialisation: WeaponSpecialisation.oneHanded,
      damage: '4+StrB',
      enc: 1,
      cost: 3000,
      availability: WeaponAvailability.rare,
      source: 'core book',
      traits: [
        weaponTraitPenetrating4,
      ],
    ),
  ],
);

const presetMeleeWeaponGroups = <WeaponGroup>[
  chainWeapons,
  forceWeapons,
  mundaneWeapons,
  shockWeapons,
  powerWeapons,
];

final List<Weapon> presetMeleeWeapons = List.unmodifiable(
  presetMeleeWeaponGroups.expand((group) => group.weapons),
);
