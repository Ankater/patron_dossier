import 'force_field.dart';
import 'weapon_availability.dart';

const presetForceFields = <ForceField>[
  ForceField(
    name: 'Refractor Field',
    protection: '1d10',
    overload: 10,
    enc: 0,
    cost: 1000,
    availability: Availability.exotic,
  ),
  ForceField(
    name: 'Conversion Field',
    protection: '2d10',
    overload: 20,
    enc: 0,
    cost: 6000,
    availability: Availability.exotic,
  ),
];
