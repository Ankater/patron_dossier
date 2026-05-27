import 'package:flutter/material.dart';

import '../models/force_field.dart';
import '../models/preset_force_fields.dart';
import '../models/weapon_availability.dart';

class ForceFieldListScreen extends StatelessWidget {
  const ForceFieldListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Force Fields'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _ForceFieldDataTable(forceFields: presetForceFields),
      ),
    );
  }
}

class _ForceFieldDataTable extends StatelessWidget {
  const _ForceFieldDataTable({required this.forceFields});

  final List<ForceField> forceFields;

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
          DataColumn(label: Text('Protection')),
          DataColumn(label: Text('Overload')),
          DataColumn(label: Text('Enc')),
          DataColumn(label: Text('Cost')),
          DataColumn(label: Text('Availability')),
        ],
        rows: [
          for (final forceField in forceFields)
            DataRow(
              cells: [
                DataCell(Text(forceField.name)),
                DataCell(Text(forceField.protection)),
                DataCell(Text(forceField.overload.toString())),
                DataCell(Text(forceField.enc.toString())),
                DataCell(Text(forceField.cost.toString())),
                DataCell(Text(forceField.availability.label)),
              ],
            ),
        ],
      ),
    );
  }
}
