import 'package:flutter/material.dart';

import '../models/armour.dart';
import '../models/armour_group.dart';
import '../models/location_armour.dart';
import '../models/preset_armours.dart';
import '../models/weapon_availability.dart';

class ArmourListScreen extends StatelessWidget {
  const ArmourListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Armour'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final group in presetArmourGroups) ...[
              Text(
                group.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _ArmourDataTable(group: group),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}

class _ArmourDataTable extends StatelessWidget {
  const _ArmourDataTable({required this.group});

  final ArmourGroup group;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 40,
        dataRowMinHeight: 44,
        dataRowMaxHeight: 72,
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Locations')),
          DataColumn(label: Text('Armour')),
          DataColumn(label: Text('Enc')),
          DataColumn(label: Text('Cost')),
          DataColumn(label: Text('Availability')),
          DataColumn(label: Text('Traits')),
        ],
        rows: [
          for (final armour in group.armours)
            DataRow(
              cells: [
                DataCell(Text(armour.name)),
                DataCell(Text(_formatLocations(armour.locationArmour))),
                DataCell(
                  Text(armour.locationArmour?.armourValue.toString() ?? '-'),
                ),
                DataCell(Text(armour.enc.toString())),
                DataCell(Text(armour.cost.toString())),
                DataCell(Text(armour.availability.label)),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Text(_formatTraits(armour)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _formatLocations(LocationArmour? locationArmour) {
    if (locationArmour == null) {
      return 'Special';
    }

    final locations = [
      if (locationArmour.arms != null) 'Arms',
      if (locationArmour.body != null) 'Body',
      if (locationArmour.legs != null) 'Legs',
      if (locationArmour.head != null) 'Head',
    ];

    if (locations.length == 4) {
      return 'All';
    }
    return locations.join(', ');
  }

  String _formatTraits(Armour armour) {
    if (armour.traits.isEmpty) {
      return '-';
    }
    return armour.traits.map((trait) => trait.name).join(', ');
  }
}
