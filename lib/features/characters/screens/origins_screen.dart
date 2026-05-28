import 'dart:math';

import 'package:flutter/material.dart';

import '../models/characteristic.dart';
import '../models/character_builder.dart';
import '../models/character_stats.dart';
import '../models/origin.dart';
import '../models/preset_origins.dart';
import '../models/stat_definition.dart';

class OriginsScreen extends StatefulWidget {
  const OriginsScreen({
    super.key,
    required this.builder,
    required this.onComplete,
  });

  final CharacterBuilder builder;
  final void Function(CharacterBuilder) onComplete;

  @override
  State<OriginsScreen> createState() => _OriginsScreenState();
}

class _OriginsScreenState extends State<OriginsScreen> {
  Origin? _selectedOrigin;
  Characteristic? _selectedBonus;

  /// Stats with origin bonuses applied as a live preview.
  ///
  /// Returns base stats when no origin is selected, applies the fixed bonus
  /// always once an origin is chosen, and layers the chosen selectable bonus
  /// on top once the user picks one.
  CharacterStats get _previewStats {
    final base = widget.builder.character.stats;
    if (_selectedOrigin == null) return base;
    var result = _selectedOrigin!.bonusCharacteristic.applyBonus(base);
    if (_selectedBonus != null) {
      result = _selectedBonus!.applyBonus(result);
    }
    return result;
  }

  void _rollOrigin() {
    final index = Random().nextInt(presetOrigins.length);
    setState(() {
      _selectedOrigin = presetOrigins[index];
      _selectedBonus = null;
    });
  }

  void _selectOrigin(Origin origin) {
    setState(() {
      _selectedOrigin = origin;
      _selectedBonus = null;
    });
  }

  void _changeOrigin() {
    setState(() {
      _selectedOrigin = null;
      _selectedBonus = null;
    });
  }

  void _confirm() {
    // TODO: apply bonuses, award EXP, and complete character creation.
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preview = _previewStats;

    return Scaffold(
      appBar: AppBar(title: const Text('Origin')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      'EXP: ${widget.builder.exp}',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    _buildStatsGrid(preview, theme),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _selectedOrigin == null
                ? _buildOriginList(theme)
                : _buildBonusSelection(theme),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _selectedOrigin == null
                ? FilledButton.icon(
                    icon: const Icon(Icons.casino),
                    label: const Text('Roll origin  (+25 EXP)'),
                    onPressed: _rollOrigin,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        onPressed: _changeOrigin,
                        child: const Text('Change origin'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: _selectedBonus != null ? _confirm : null,
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(CharacterStats preview, ThemeData theme) {
    final base = widget.builder.character.stats;
    return Column(
      children: [
        for (var row = 0; row < 3; row++)
          Row(
            children: [
              for (var col = 0; col < 3; col++)
                Expanded(
                  child: _buildStatCell(
                    statDefinitions[row * 3 + col],
                    base,
                    preview,
                    theme,
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildStatCell(
    StatDefinition def,
    CharacterStats base,
    CharacterStats preview,
    ThemeData theme,
  ) {
    final baseValue = def.getter(base);
    final previewValue = def.getter(preview);
    final isHighlighted = previewValue > baseValue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Column(
        children: [
          Text(def.label, style: theme.textTheme.labelSmall),
          Text(
            '$previewValue',
            style: theme.textTheme.titleMedium?.copyWith(
              color: isHighlighted ? theme.colorScheme.primary : null,
              fontWeight: isHighlighted ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOriginList(ThemeData theme) {
    // Eight items are few enough to build eagerly — no lazy loading needed,
    // and eager building keeps all rows in the tree for testability.
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          for (var i = 0; i < presetOrigins.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            ListTile(
              title: Text(presetOrigins[i].name),
              subtitle: Text(
                '+5 ${presetOrigins[i].bonusCharacteristic.label}  •  '
                'choose: ${presetOrigins[i].bonusSelectCharacteristic.map((c) => c.label).join(', ')}',
              ),
              onTap: () => _selectOrigin(presetOrigins[i]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBonusSelection(ThemeData theme) {
    final origin = _selectedOrigin!;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(origin.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Fixed bonus: +5 ${origin.bonusCharacteristic.label}',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Choose an additional +5 bonus:',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final char in origin.bonusSelectCharacteristic)
                ChoiceChip(
                  label: Text(char.label),
                  selected: _selectedBonus == char,
                  onSelected: (selected) => setState(() {
                    _selectedBonus = selected ? char : null;
                  }),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
