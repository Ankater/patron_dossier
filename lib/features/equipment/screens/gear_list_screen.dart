import 'package:flutter/material.dart';

import '../models/gear.dart';
import '../models/preset_gear.dart';
import '../models/weapon_availability.dart';

class GearListScreen extends StatelessWidget {
  const GearListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gear'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final group in presetGearGroups) ...[
              Text(
                group.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _GearDataTable(
                gear: [
                  for (final item in presetGear)
                    if (item.group == group) item,
                ],
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}

class _GearDataTable extends StatelessWidget {
  const _GearDataTable({required this.gear});

  final List<Gear> gear;

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
          DataColumn(label: Text('Enc')),
          DataColumn(label: Text('Cost')),
          DataColumn(label: Text('Avail')),
          DataColumn(label: Text('Source')),
        ],
        rows: [
          for (final item in gear)
            DataRow(
              cells: [
                DataCell(Text(item.name)),
                DataCell(Text(item.enc.toString())),
                DataCell(Text(item.cost.toString())),
                DataCell(Text(item.availability.label)),
                DataCell(Text(item.source)),
              ],
            ),
        ],
      ),
    );
  }
}
