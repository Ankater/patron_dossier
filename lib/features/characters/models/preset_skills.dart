import 'characteristic.dart';
import 'skill.dart';

const presetSkills = <Skill>[
  Skill(
    name: 'Athletics',
    characteristic: Characteristic.str,
    specialisations: [
      'Climbing',
      'Might',
      'Riding',
      'Running',
      'Swimming',
    ],
  ),
  Skill(
    name: 'Awareness',
    characteristic: Characteristic.per,
    specialisations: [
      'Sight',
      'Smell',
      'Hearing',
      'Taste',
      'Touch',
      'Psyniscience (Restricted)',
    ],
  ),
  Skill(
    name: 'Dexterity',
    characteristic: Characteristic.ag,
    specialisations: [
      'Lock Picking',
      'Pickpocket',
      'Sleight of Hand',
      'Defuse (Restricted)',
    ],
  ),
  Skill(
    name: 'Discipline',
    characteristic: Characteristic.wil,
    specialisations: [
      'Composure',
      'Fear',
      'Psychic',
    ],
  ),
  Skill(
    name: 'Fortitude',
    characteristic: Characteristic.tgh,
    specialisations: [
      'Endurance',
      'Pain',
      'Poison',
    ],
  ),
  Skill(
    name: 'Intuition',
    characteristic: Characteristic.per,
    specialisations: [
      'Human',
      'Group (Various)',
      'Surroundings',
    ],
  ),
  Skill(
    name: 'Linguistics',
    characteristic: Characteristic.intel,
    specialisations: [
      'Cypher',
      'High Gothic',
      'Forbidden (Various, Restricted)',
    ],
  ),
  Skill(
    name: 'Logic',
    characteristic: Characteristic.intel,
    specialisations: [
      'Evaluation',
      'Investigation',
    ],
  ),
  Skill(
    name: 'Lore',
    characteristic: Characteristic.intel,
    specialisations: [
      'Academics',
      'Adeptus Terra',
      'Planet',
      'Sector',
      'Theology (Restricted)',
      'Forbidden (Various, Restricted)',
    ],
  ),
  Skill(
    name: 'Medicae',
    characteristic: Characteristic.intel,
    specialisations: [
      'Animal',
      'Human',
      'Forbidden (Various, Restricted)',
    ],
  ),
  Skill(
    name: 'Melee',
    characteristic: Characteristic.ws,
    specialisations: [
      'Brawling',
      'One-handed',
      'Two-handed',
    ],
  ),
  Skill(
    name: 'Navigation',
    characteristic: Characteristic.intel,
    specialisations: [
      'Surface',
      'Tracking',
      'Void',
      'Warp (Restricted)',
    ],
  ),
  Skill(
    name: 'Piloting',
    characteristic: Characteristic.ag,
    specialisations: [
      'Aeronautica',
      'Civilian',
      'Personal Transports',
      'Military (Restricted)',
      'Minor Voidship (Restricted)',
      'Major Voidship (Restricted)',
    ],
  ),
  Skill(
    name: 'Presence',
    characteristic: Characteristic.wil,
    specialisations: [
      'Interrogation',
      'Intimidation',
      'Leadership',
    ],
  ),
  Skill(
    name: 'Psychic Mastery',
    characteristic: Characteristic.wil,
    specialisations: [
      'Biomancy',
      'Divination',
      'Pyromancy',
      'Telekinesis',
      'Telepathy',
    ],
  ),
  Skill(
    name: 'Ranged',
    characteristic: Characteristic.bs,
    specialisations: [
      'Long Guns',
      'Ordnance',
      'Pistols',
      'Thrown',
    ],
  ),
  Skill(
    name: 'Rapport',
    characteristic: Characteristic.fel,
    specialisations: [
      'Animals',
      'Charm',
      'Deception',
      'Haggle',
      'Inquiry',
    ],
  ),
  Skill(
    name: 'Reflexes',
    characteristic: Characteristic.ag,
    specialisations: [
      'Acrobatics',
      'Balance',
      'Dodge',
    ],
  ),
  Skill(
    name: 'Stealth',
    characteristic: Characteristic.ag,
    specialisations: [
      'Conceal',
      'Hide',
      'Move Silently',
    ],
  ),
  Skill(
    name: 'Tech',
    characteristic: Characteristic.intel,
    specialisations: [
      'Augmetics (Restricted)',
      'Engineering',
      'Security',
    ],
  ),
];
