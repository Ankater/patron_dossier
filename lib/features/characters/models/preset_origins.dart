import '../../../features/equipment/models/character_gear.dart';
import '../../../features/equipment/models/gear_property.dart';
import '../../../features/equipment/models/weapon_availability.dart';
import 'characteristic.dart';
import 'origin.dart';

const _shoddy = Flaw(name: 'Shoddy', source: 'core book');
const _ugly = Flaw(name: 'Ugly', source: 'core book');

const presetOrigins = <Origin>[
  Origin(
    name: 'Agri World',
    bonusCharacteristic: Characteristic.str,
    bonusSelectCharacteristic: [
      Characteristic.tgh,
      Characteristic.ag,
      Characteristic.wil,
    ],
    characterGear: CharacterGear(
      name: 'Entrenching Tool',
      enc: 1,
      cost: 20,
      availability: Availability.common,
      group: 'Tools',
      source: 'core book',
      flaws: [_shoddy],
    ),
    source: 'core book',
  ),
  Origin(
    name: 'Feudal World',
    bonusCharacteristic: Characteristic.ws,
    bonusSelectCharacteristic: [
      Characteristic.str,
      Characteristic.wil,
      Characteristic.fel,
    ],
    characterGear: CharacterGear(
      name: 'Writing Kit',
      enc: 1,
      cost: 20,
      availability: Availability.common,
      group: 'Tools',
      source: 'core book',
      flaws: [_shoddy],
    ),
    source: 'core book',
  ),
  Origin(
    name: 'Feral World',
    bonusCharacteristic: Characteristic.tgh,
    bonusSelectCharacteristic: [
      Characteristic.ws,
      Characteristic.str,
      Characteristic.per,
    ],
    characterGear: CharacterGear(
      name: 'Survival Gear',
      enc: 3,
      cost: 50,
      availability: Availability.common,
      group: 'Clothing and Personal Gear',
      source: 'core book',
      flaws: [_shoddy],
    ),
    source: 'core book',
  ),
  Origin(
    name: 'Forge World',
    bonusCharacteristic: Characteristic.intel,
    bonusSelectCharacteristic: [
      Characteristic.bs,
      Characteristic.tgh,
      Characteristic.ag,
    ],
    characterGear: CharacterGear(
      name: 'Sacred Unguents (5 uses)',
      enc: 0,
      cost: 100,
      availability: Availability.rare,
      group: 'Tools',
      source: 'core book',
    ),
    source: 'core book',
  ),
  Origin(
    name: 'Hive World',
    bonusCharacteristic: Characteristic.ag,
    bonusSelectCharacteristic: [
      Characteristic.bs,
      Characteristic.per,
      Characteristic.fel,
    ],
    characterGear: CharacterGear(
      name: 'Filtration Plugs',
      enc: 0,
      cost: 20,
      availability: Availability.common,
      group: 'Clothing and Personal Gear',
      source: 'core book',
      flaws: [_ugly],
    ),
    source: 'core book',
  ),
  Origin(
    name: 'Shrine World',
    bonusCharacteristic: Characteristic.wil,
    bonusSelectCharacteristic: [
      Characteristic.intel,
      Characteristic.per,
      Characteristic.fel,
    ],
    characterGear: CharacterGear(
      name: 'Holy Icon',
      enc: 0,
      cost: 10,
      availability: Availability.common,
      group: 'Tools',
      source: 'core book',
    ),
    source: 'core book',
  ),
  Origin(
    name: 'Schola Progenium',
    bonusCharacteristic: Characteristic.fel,
    bonusSelectCharacteristic: [
      Characteristic.ws,
      Characteristic.bs,
      Characteristic.tgh,
    ],
    characterGear: CharacterGear(
      name: 'Chrono',
      enc: 0,
      cost: 20,
      availability: Availability.common,
      group: 'Tools',
      source: 'core book',
    ),
    source: 'core book',
  ),
  Origin(
    name: 'Voidborn',
    bonusCharacteristic: Characteristic.per,
    bonusSelectCharacteristic: [
      Characteristic.ag,
      Characteristic.intel,
      Characteristic.wil,
    ],
    characterGear: CharacterGear(
      name: 'Mag Boots',
      enc: 0,
      cost: 400,
      availability: Availability.rare,
      group: 'Tools',
      source: 'core book',
      flaws: [_shoddy],
    ),
    source: 'core book',
  ),
];
