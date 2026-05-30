import 'package:flutter/material.dart';

import '../models/augment.dart';
import '../models/preset_augments.dart';
import '../models/weapon_availability.dart';

class AugmentListScreen extends StatelessWidget {
  const AugmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Augments'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              augmentGroupAugmeticReplacements.toUpperCase(),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const _AugmentReplacementDataTable(
              augments: presetAugmeticReplacements,
            ),
            const SizedBox(height: 20),
            Text(
              augmentGroupAugmetics.toUpperCase(),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const _AugmentDataTable(augments: presetAugmetics),
          ],
        ),
      ),
    );
  }
}

class _AugmentReplacementDataTable extends StatelessWidget {
  const _AugmentReplacementDataTable({required this.augments});

  final List<AugmentReplacement> augments;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 40,
        dataRowMinHeight: 44,
        dataRowMaxHeight: 96,
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Slot')),
          DataColumn(label: Text('Body')),
          DataColumn(label: Text('Armour')),
          DataColumn(label: Text('Cost')),
          DataColumn(label: Text('Availability')),
          DataColumn(label: Text('Features')),
        ],
        rows: [
          for (final augment in augments)
            DataRow(
              cells: [
                DataCell(Text(augment.name)),
                DataCell(Text(augment.slot.name)),
                DataCell(Text(_formatBodySlot(augment.bodySlot))),
                DataCell(Text(
                    augment.locationArmour?.armourValue.toString() ?? '-')),
                DataCell(Text(augment.cost.toString())),
                DataCell(Text(augment.availability.label)),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Text(_formatFeatures(augment)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _AugmentDataTable extends StatelessWidget {
  const _AugmentDataTable({required this.augments});

  final List<Augment> augments;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 40,
        dataRowMinHeight: 44,
        dataRowMaxHeight: 96,
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Cost')),
          DataColumn(label: Text('Availability')),
          DataColumn(label: Text('Features')),
        ],
        rows: [
          for (final augment in augments)
            DataRow(
              cells: [
                DataCell(Text(augment.name)),
                DataCell(Text(augment.cost.toString())),
                DataCell(Text(augment.availability.label)),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Text(_formatFeatures(augment)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

String _formatBodySlot(BodySlot bodySlot) {
  switch (bodySlot) {
    case BodySlot.arm:
      return 'Arm';
    case BodySlot.heart:
      return 'Heart';
    case BodySlot.legs:
      return 'Legs';
    case BodySlot.lungs:
      return 'Lungs';
    case BodySlot.eye:
      return 'Eye';
  }
}

String _formatFeatures(Augment augment) {
  if (augment.featureDescriptions.isEmpty) {
    return '-';
  }
  return augment.featureDescriptions.join('\n');
}
