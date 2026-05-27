import 'armour.dart';
import 'armour_group.dart';
import 'location_armour.dart';
import 'preset_armour_traits.dart';
import 'preset_weapon_traits.dart';
import 'weapon_availability.dart';

const _allLocations4 = LocationArmour(arms: 4, body: 4, legs: 4, head: 4);
const _allLocations5 = LocationArmour(arms: 5, body: 5, legs: 5, head: 5);
const _allLocations6 = LocationArmour(arms: 6, body: 6, legs: 6, head: 6);
const _allLocations8 = LocationArmour(arms: 8, body: 8, legs: 8, head: 8);
const _allLocations10 = LocationArmour(
  arms: 10,
  body: 10,
  legs: 10,
  head: 10,
);
const _armsBody3 = LocationArmour(arms: 3, body: 3);
const _armsBodyLegs1 = LocationArmour(arms: 1, body: 1, legs: 1);
const _armsBodyLegs2 = LocationArmour(arms: 2, body: 2, legs: 2);
const _armsBodyLegs4 = LocationArmour(arms: 4, body: 4, legs: 4);
const _arms2 = LocationArmour(arms: 2);
const _arms3 = LocationArmour(arms: 3);
const _arms5 = LocationArmour(arms: 5);
const _body3 = LocationArmour(body: 3);
const _body4 = LocationArmour(body: 4);
const _body6 = LocationArmour(body: 6);
const _head2 = LocationArmour(head: 2);
const _head3 = LocationArmour(head: 3);
const _head5 = LocationArmour(head: 5);
const _legs2 = LocationArmour(legs: 2);
const _legs3 = LocationArmour(legs: 3);
const _legs5 = LocationArmour(legs: 5);

const basicArmours = ArmourGroup(
  name: 'Basic',
  armours: [
    Armour(
      name: 'Robes/Light Leathers',
      locationArmour: _armsBodyLegs1,
      enc: 1,
      cost: 10,
      availability: Availability.common,
      traits: [weaponTraitSubtle],
    ),
    Armour(
      name: 'Heavy Leathers',
      locationArmour: _armsBodyLegs2,
      enc: 1,
      cost: 60,
      availability: Availability.common,
      traits: [],
    ),
    Armour(
      name: 'Armoured Bodyglove',
      locationArmour: _armsBodyLegs2,
      enc: 1,
      cost: 1200,
      availability: Availability.rare,
      traits: [weaponTraitSubtle],
    ),
    Armour(
      name: 'Armoured Greatcoat',
      locationArmour: _armsBodyLegs2,
      enc: 2,
      cost: 500,
      availability: Availability.rare,
      traits: [weaponTraitSubtle],
    ),
    Armour(
      name: 'Scrap-plate',
      locationArmour: _body3,
      enc: 2,
      cost: 300,
      availability: Availability.rare,
      traits: [armourTraitHeavy3],
    ),
    Armour(
      name: 'Combat Shield',
      locationArmour: null,
      enc: 2,
      cost: 700,
      availability: Availability.common,
      traits: [armourTraitShield2],
    ),
    Armour(
      name: 'Boarding Shield',
      locationArmour: null,
      enc: 4,
      cost: 1400,
      availability: Availability.rare,
      traits: [armourTraitShield4],
    ),
    Armour(
      name: 'Xenos Hide Vest',
      locationArmour: _body6,
      enc: 1,
      cost: 5000,
      availability: Availability.exotic,
      traits: [],
    ),
  ],
);

const flakArmours = ArmourGroup(
  name: 'Flak',
  armours: [
    Armour(
      name: 'Flak Boots',
      locationArmour: _legs2,
      enc: 2,
      cost: 100,
      availability: Availability.common,
      traits: [],
    ),
    Armour(
      name: 'Flak Helmet',
      locationArmour: _head2,
      enc: 2,
      cost: 150,
      availability: Availability.common,
      traits: [],
    ),
    Armour(
      name: 'Flak Gauntlets (pair)',
      locationArmour: _arms2,
      enc: 1,
      cost: 100,
      availability: Availability.common,
      traits: [],
    ),
    Armour(
      name: 'Flak Vest',
      locationArmour: _body3,
      enc: 2,
      cost: 500,
      availability: Availability.common,
      traits: [],
    ),
    Armour(
      name: 'Flak Jacket',
      locationArmour: _armsBody3,
      enc: 2,
      cost: 800,
      availability: Availability.scarce,
      traits: [],
    ),
    Armour(
      name: 'Astra Militarum Flak Armour',
      locationArmour: _allLocations4,
      enc: 4,
      cost: 1000,
      availability: Availability.rare,
      traits: [weaponTraitLoud],
    ),
  ],
);

const meshArmours = ArmourGroup(
  name: 'Mesh',
  armours: [
    Armour(
      name: 'Mesh Boots',
      locationArmour: _legs3,
      enc: 1,
      cost: 600,
      availability: Availability.rare,
      traits: [],
    ),
    Armour(
      name: 'Mesh Cowl',
      locationArmour: _head3,
      enc: 1,
      cost: 800,
      availability: Availability.rare,
      traits: [],
    ),
    Armour(
      name: 'Mesh Gauntlets',
      locationArmour: _arms3,
      enc: 0,
      cost: 600,
      availability: Availability.rare,
      traits: [],
    ),
    Armour(
      name: 'Mesh Vest',
      locationArmour: _body4,
      enc: 1,
      cost: 500,
      availability: Availability.rare,
      traits: [],
    ),
    Armour(
      name: 'Xenos Mesh',
      locationArmour: _armsBodyLegs4,
      enc: 2,
      cost: 5000,
      availability: Availability.exotic,
      traits: [],
    ),
  ],
);

const carapaceArmours = ArmourGroup(
  name: 'Carapace',
  armours: [
    Armour(
      name: 'Carapace Helm',
      locationArmour: _head5,
      enc: 2,
      cost: 400,
      availability: Availability.rare,
      traits: [],
    ),
    Armour(
      name: 'Carapace Gauntlets',
      locationArmour: _arms5,
      enc: 2,
      cost: 300,
      availability: Availability.rare,
      traits: [],
    ),
    Armour(
      name: 'Carapace Greaves',
      locationArmour: _legs5,
      enc: 2,
      cost: 300,
      availability: Availability.rare,
      traits: [],
    ),
    Armour(
      name: 'Carapace Chestplate',
      locationArmour: _body6,
      enc: 3,
      cost: 800,
      availability: Availability.rare,
      traits: [weaponTraitHeavy4, weaponTraitLoud],
    ),
    Armour(
      name: 'Enforcer Carapace',
      locationArmour: _allLocations5,
      enc: 4,
      cost: 1800,
      availability: Availability.rare,
      traits: [weaponTraitHeavy4, weaponTraitLoud],
    ),
    Armour(
      name: 'Tempestus Carapace',
      locationArmour: _allLocations6,
      enc: 5,
      cost: 4000,
      availability: Availability.exotic,
      traits: [weaponTraitHeavy4, weaponTraitLoud],
    ),
  ],
);

const powerArmours = ArmourGroup(
  name: 'Power',
  armours: [
    Armour(
      name: 'Light Power Armour',
      locationArmour: _allLocations8,
      enc: 7,
      cost: 500000,
      availability: Availability.exotic,
      traits: [weaponTraitLoud],
    ),
    Armour(
      name: 'Power Armour',
      locationArmour: _allLocations10,
      enc: 9,
      cost: 1000000,
      availability: Availability.exotic,
      traits: [weaponTraitLoud],
    ),
  ],
);

const presetArmourGroups = <ArmourGroup>[
  basicArmours,
  flakArmours,
  meshArmours,
  carapaceArmours,
  powerArmours,
];

final List<Armour> presetArmours = List.unmodifiable(
  presetArmourGroups.expand((group) => group.armours),
);
