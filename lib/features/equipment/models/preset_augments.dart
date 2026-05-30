import 'augment.dart';
import 'location_armour.dart';
import 'weapon_availability.dart';

const augmentGroupAugmeticReplacements = 'Augmetic Replacements';
const augmentGroupAugmetics = 'Augmetics';

const presetAugmentGroups = [
  augmentGroupAugmeticReplacements,
  augmentGroupAugmetics,
];

const augmeticArmSlot = Slot(name: 'Arm');
const augmeticHeartSlot = Slot(name: 'Heart');
const augmeticLegSlot = Slot(name: 'Leg');
const augmeticLungsSlot = Slot(name: 'Lungs');
const augmeticEyeSlot = Slot(name: 'Eye');

const presetAugmeticReplacements = <AugmentReplacement>[
  AugmentReplacement(
    name: 'Augmetic Arm',
    cost: 1000,
    availability: Availability.scarce,
    featureDescriptions: [
      'The arm grants +1 Armour, which is added to any other Armour in the '
          'location.',
      'You gain +1 SL to all Strength-based Tests using the arm, and melee '
          'attacks with the arm deal +1 Damage.',
      'If you have two augmetic arms, you gain +2 SL to Strength-based Tests '
          'using both arms, and deal +2 Damage with Two-handed melee weapons.',
    ],
    slot: augmeticArmSlot,
    locationArmour: LocationArmour(arms: 1),
    bodySlot: BodySlot.arm,
  ),
  AugmentReplacement(
    name: 'Augmetic Heart',
    cost: 3000,
    availability: Availability.rare,
    featureDescriptions: [
      'As an Action, you can make a Challenging (+0) Fortitude Test to remove '
          'the Bleeding (Minor) Condition.',
      'As an Action, you can make a Hard (-20) Fortitude Test to remove the '
          'Bleeding (Major) Condition.',
    ],
    slot: augmeticHeartSlot,
    bodySlot: BodySlot.heart,
  ),
  AugmentReplacement(
    name: 'Augmetic Leg',
    cost: 1000,
    availability: Availability.scarce,
    featureDescriptions: [
      'The leg grants +1 Armour, which is added to any other Armour in the '
          'location.',
      'You gain +1 SL to all Strength-based Tests using the leg, such as '
          'kicking in a door.',
    ],
    slot: augmeticLegSlot,
    locationArmour: LocationArmour(legs: 1),
    bodySlot: BodySlot.legs,
  ),
  AugmentReplacement(
    name: 'Augmetic Respiratory System',
    cost: 2000,
    availability: Availability.rare,
    featureDescriptions: [
      'You gain +2 SL to Fortitude Tests to resist the effects of airborne '
          'toxins and poisonous gases.',
    ],
    slot: augmeticLungsSlot,
    bodySlot: BodySlot.lungs,
  ),
  AugmentReplacement(
    name: 'Augmetic Sensory Organs',
    cost: 4000,
    availability: Availability.rare,
    featureDescriptions: [
      'You gain +1 SL to Tests using that sense.',
      'If you have two augmetic eyes or two augmetic ears, you gain +2 SL '
          'instead.',
    ],
    slot: augmeticEyeSlot,
    bodySlot: BodySlot.eye,
  ),
  AugmentReplacement(
    name: 'Augmetic Tracks/Wheels',
    cost: 1500,
    availability: Availability.scarce,
    featureDescriptions: [
      'Your new form of locomotion grants +1 Armour, which is added to any '
          'other Armour in the location.',
      'In clear Zones suitable for tracks or wheels, your speed is now Fast.',
      'The GM can rule that cluttered Zones count as Difficult Terrain for '
          'you.',
    ],
    slot: augmeticLegSlot,
    locationArmour: LocationArmour(legs: 1),
    bodySlot: BodySlot.legs,
  ),
];

const presetAugmetics = <Augment>[
  Augment(
    name: 'Augur Array',
    cost: 6000,
    availability: Availability.rare,
    featureDescriptions: [
      "The user's senses gain the abilities of an Auspex, revealing energy, "
          'life signs, movement, and other data within Medium Range.',
      'The user also gains +5 Perception.',
    ],
  ),
  Augment(
    name: 'Ballistic Mechadendrite',
    cost: 2000,
    availability: Availability.rare,
    featureDescriptions: [
      'The Mechadendrite is fitted with a Laspistol that never needs '
          'reloading.',
    ],
  ),
  Augment(
    name: 'Calculus Logi Upgrade',
    cost: 10000,
    availability: Availability.rare,
    featureDescriptions: [
      'The user can perform simple mathematics instinctively, gaining +1 SL '
          'on any Logic (Mathematics) Tests.',
      'The user also gains +5 Intelligence.',
    ],
  ),
  Augment(
    name: 'Manipulator Mechadendrite',
    cost: 1400,
    availability: Availability.rare,
    featureDescriptions: [
      'This hefty Mechadendrite aids in heavy lifting.',
      'When using a Manipulator Mechadendrite, you gain +2 SL to '
          'Strength-based Tests, and -1 SL to Dexterity Tests.',
      'It can also be used as an Improvised Melee Weapon (Two-handed).',
    ],
  ),
  Augment(
    name: 'Medicae Mechadendrite',
    cost: 1400,
    availability: Availability.rare,
    featureDescriptions: [
      'This device includes scalpels, bonesaws, and skin-sealants for '
          'surgical support.',
      "The Mechadendrite counts as having a Chirurgeon's Kit for Tests that "
          'require one.',
      "Unlike a standard Chirurgeon's Kit, a Medicae Mechadendrite's "
          'advanced tools do not have a limited number of uses and only need '
          'to be replaced if the device is broken.',
    ],
  ),
  Augment(
    name: 'Mind Impulse Unit',
    cost: 10000,
    availability: Availability.rare,
    featureDescriptions: [
      'The user gains +1 SL to Tech Tests when operating a machine with a '
          'suitable connection, or issuing orders to a suitably equipped '
          'cybernetic servant.',
    ],
  ),
  Augment(
    name: 'Optical Mechadendrite',
    cost: 1200,
    availability: Availability.rare,
    featureDescriptions: [
      'Optical Mechadendrites are usually a metre longer than typical '
          'mechadendrites, allowing them to pass through crowded mechanisms '
          'and cramped areas to gain visual data.',
      'When using the Optical Mechadendrite, you gain +1 SL to Awareness '
          '(Sight) Tests and ignore the effects of Poorly Lit and Dark Zones '
          'due to the integrated Stablight.',
      'You can also use these to look around corners, over the heads of a '
          'thronging crowd, and in many other inventive ways.',
    ],
  ),
  Augment(
    name: 'Utility Mechadendrite',
    cost: 1000,
    availability: Availability.rare,
    featureDescriptions: [
      'These are fitted with several devices for repairing and renovating '
          'machines, and are the most common form of Mechadendrite.',
      'They count as a Standard Quality Combi-Tool, granting +2 SL to Tech '
          'Tests.',
      'They can be used in melee combat as an Improvised Melee Weapon '
          '(One-handed).',
    ],
  ),
  Augment(
    name: 'Vocal Implant',
    cost: 400,
    availability: Availability.rare,
    featureDescriptions: [
      'When using a Vocal Implant, your voice or other sounds you play or '
          'generate can be easily heard up to 100 metres away.',
    ],
  ),
];

const presetAugments = <Augment>[
  ...presetAugmeticReplacements,
  ...presetAugmetics,
];
