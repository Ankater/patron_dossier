import 'package:flutter/material.dart';

import '../models/assign_points_logic.dart';
import '../models/character_blank_object.dart';
import '../models/character_builder.dart';
import '../models/character_creation_mode.dart';
import '../models/character_stats.dart';
import '../models/dice_roller.dart';
import '../models/stat_definition.dart';
import '../widgets/stat_row.dart';
import 'origins_screen.dart';

class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key, required this.mode});

  final CharacterCreationMode mode;

  @override
  State<CharacterCreationScreen> createState() =>
      _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  late CharacterBuilder _builder;
  bool _canSwitchStats = false;
  bool _switchStatsButtonVisible = false;
  bool? _supportsAdjustedReorderCallback;

  @override
  void initState() {
    super.initState();
    _builder = _buildInitial(widget.mode);
    _switchStatsButtonVisible = widget.mode == CharacterCreationMode.rollStats;
  }

  CharacterBuilder _buildInitial(CharacterCreationMode mode) {
    if (mode == CharacterCreationMode.assignPoints) {
      return const CharacterBuilder(
        character: CharacterBlankObject(),
        assignCharPoints: 90,
        exp: 0,
      );
    }
    return CharacterBuilder(
      character: CharacterBlankObject(stats: rollCharacterStats()),
      exp: 50,
    );
  }

  void _onIncrement(StatDefinition def) {
    setState(() => _builder = incrementStat(_builder, def));
  }

  void _onDecrement(StatDefinition def) {
    setState(() => _builder = decrementStat(_builder, def));
  }

  void _reroll() {
    setState(() {
      _builder = _builder.copyWith(
        character: _builder.character.copyWith(stats: rollCharacterStats()),
        exp: 0,
      );
      _canSwitchStats = true;
      _switchStatsButtonVisible = false;
    });
  }

  void _onSwitchStats() {
    if (_builder.exp < 25) return;
    setState(() {
      _builder = _builder.copyWith(exp: _builder.exp - 25);
      _canSwitchStats = true;
      _switchStatsButtonVisible = false;
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;

    final stats = _builder.character.stats;
    final values = statDefinitions.map((d) => d.getter(stats)).toList();
    final moved = values.removeAt(oldIndex);
    values.insert(newIndex, moved);

    var result = const CharacterStats();
    for (var i = 0; i < statDefinitions.length; i++) {
      result = statDefinitions[i].updater(result, values[i]);
    }

    setState(() {
      _builder = _builder.copyWith(
        character: _builder.character.copyWith(stats: result),
      );
    });
  }

  bool _canIncrement(int current) {
    final points = _builder.assignCharPoints ?? 0;
    if (current == 20) return points >= 4;
    if (current < 38) return points >= 1;
    return false;
  }

  bool _canDecrement(int current) => current > 20;

  // Origin is unlocked in roll mode always; in assign mode only when all
  // points are spent and every stat has been raised above the baseline (≥ 24).
  bool get _originEnabled {
    if (widget.mode == CharacterCreationMode.rollStats) return true;
    if ((_builder.assignCharPoints ?? 0) != 0) return false;
    final stats = _builder.character.stats;
    return statDefinitions.every((def) => def.getter(stats) >= 24);
  }

  @override
  Widget build(BuildContext context) {
    final isAssignMode = widget.mode == CharacterCreationMode.assignPoints;
    final stats = _builder.character.stats;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Stats'),
      ),
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
                    if (isAssignMode)
                      Text(
                        'Assign points: ${_builder.assignCharPoints}',
                        style: theme.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    Text(
                      'EXP: ${_builder.exp}',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_canSwitchStats && !isAssignMode)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                'Drag stats to switch values',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: _canSwitchStats && !isAssignMode
                ? _buildReorderableStatList(stats, theme)
                : _buildStatList(stats, isAssignMode),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!isAssignMode) ...[
                  if (_switchStatsButtonVisible) ...[
                    OutlinedButton.icon(
                      icon: const Icon(Icons.swap_vert),
                      label: const Text('Switch stats  (costs 25 EXP)'),
                      onPressed: _builder.exp >= 25 ? _onSwitchStats : null,
                    ),
                    const SizedBox(height: 8),
                  ],
                  FilledButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reroll'),
                    onPressed: _reroll,
                  ),
                  const SizedBox(height: 8),
                ],
                FilledButton.icon(
                  icon: const Icon(Icons.person_search),
                  label: const Text('Origin'),
                  onPressed: _originEnabled
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => OriginsScreen(
                                builder: _builder,
                                onComplete: (updated) =>
                                    setState(() => _builder = updated),
                              ),
                            ),
                          )
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReorderableStatList(CharacterStats stats, ThemeData theme) {
    return _buildCompatibleReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: statDefinitions.length,
      onReorderItem: _onReorder,
      itemBuilder: (context, index) {
        final def = statDefinitions[index];
        final value = def.getter(stats);
        return Padding(
          key: ValueKey(def.label),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.drag_handle,
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
              SizedBox(
                width: 52,
                child: Text(
                  def.label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text('$value', style: theme.textTheme.bodyLarge),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompatibleReorderableListView({
    required EdgeInsetsGeometry padding,
    required int itemCount,
    required ReorderCallback onReorderItem,
    required IndexedWidgetBuilder itemBuilder,
  }) {
    final builder = ReorderableListView.builder;
    final baseArguments = <Symbol, dynamic>{
      #padding: padding,
      #itemCount: itemCount,
      #itemBuilder: itemBuilder,
    };

    // Flutter 3.44 replaces onReorder with onReorderItem, while older SDKs
    // still require onReorder. Dynamic invocation keeps both SDK ranges
    // compiling without binding statically to the deprecated named parameter.
    if (_supportsAdjustedReorderCallback != false) {
      try {
        final list = Function.apply(
          builder,
          const [],
          <Symbol, dynamic>{
            ...baseArguments,
            #onReorderItem: onReorderItem,
          },
        ) as Widget;
        _supportsAdjustedReorderCallback = true;
        return list;
      } on NoSuchMethodError {
        _supportsAdjustedReorderCallback = false;
      }
    }

    return Function.apply(
      builder,
      const [],
      <Symbol, dynamic>{
        ...baseArguments,
        #onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          onReorderItem(oldIndex, newIndex);
        },
      },
    ) as Widget;
  }

  Widget _buildStatList(CharacterStats stats, bool isAssignMode) {
    // Nine items are few enough to build eagerly — no lazy loading needed,
    // and eager building keeps all rows in the tree for testability.
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          for (var i = 0; i < statDefinitions.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            StatRow(
              label: statDefinitions[i].label,
              value: statDefinitions[i].getter(stats),
              showControls: isAssignMode,
              canIncrement: isAssignMode &&
                  _canIncrement(statDefinitions[i].getter(stats)),
              canDecrement: isAssignMode &&
                  _canDecrement(statDefinitions[i].getter(stats)),
              onIncrement: () => _onIncrement(statDefinitions[i]),
              onDecrement: () => _onDecrement(statDefinitions[i]),
            ),
          ],
        ],
      ),
    );
  }
}
