import 'package:flutter/material.dart';

import '../models/preset_grenades_and_explosives.dart';
import '../models/preset_melee_weapons.dart';
import '../models/preset_ranged_weapons.dart';
import '../models/weapon.dart';
import '../models/weapon_availability.dart';
import '../models/weapon_group.dart';
import '../models/weapon_specialisation.dart';

class WeaponListScreen extends StatelessWidget {
  const WeaponListScreen({super.key});

  static const _rangedGroups = <WeaponGroup>[
    ...presetRangedWeaponGroups,
    ...presetGrenadeAndExplosiveGroups,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weapons'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WeaponCategorySection(
              title: 'Melee',
              groups: presetMeleeWeaponGroups,
              showRangeAndMag: false,
            ),
            const SizedBox(height: 32),
            _WeaponCategorySection(
              title: 'Ranged',
              groups: _rangedGroups,
              showRangeAndMag: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _WeaponCategorySection extends StatelessWidget {
  const _WeaponCategorySection({
    required this.title,
    required this.groups,
    required this.showRangeAndMag,
  });

  final String title;
  final List<WeaponGroup> groups;
  final bool showRangeAndMag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 12),
        for (final group in groups) ...[
          Text(
            group.name.toUpperCase(),
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _WeaponDataTable(
            weapons: group.weapons,
            showRangeAndMag: showRangeAndMag,
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}

class _WeaponDataTable extends StatelessWidget {
  const _WeaponDataTable({
    required this.weapons,
    required this.showRangeAndMag,
  });

  final List<Weapon> weapons;
  final bool showRangeAndMag;

  @override
  Widget build(BuildContext context) {
    final columns = [
      const DataColumn(label: Text('Name')),
      const DataColumn(label: Text('Specialisation')),
      const DataColumn(label: Text('Dam')),
      if (showRangeAndMag) ...[
        const DataColumn(label: Text('Range')),
        const DataColumn(label: Text('Mag')),
      ],
      const DataColumn(label: Text('Enc')),
      const DataColumn(label: Text('Cost')),
      const DataColumn(label: Text('Avail')),
      const DataColumn(label: Text('Traits')),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 40,
        dataRowMinHeight: 44,
        dataRowMaxHeight: 72,
        columns: columns,
        rows: [
          for (final weapon in weapons)
            DataRow(
              cells: [
                DataCell(Text(weapon.name)),
                DataCell(Text(weapon.specialisation.label)),
                DataCell(Text(weapon.damage)),
                if (showRangeAndMag) ...[
                  DataCell(Text(weapon.range ?? '-')),
                  DataCell(Text(weapon.mag?.toString() ?? '-')),
                ],
                DataCell(Text(weapon.enc.toString())),
                DataCell(Text(weapon.cost?.toString() ?? '-')),
                DataCell(Text(weapon.availability?.label ?? '-')),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Text(_formatTraits(weapon)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _formatTraits(Weapon weapon) {
    if (weapon.traits.isEmpty) {
      return '-';
    }
    return weapon.traits.map((trait) => trait.name).join(', ');
  }
}
