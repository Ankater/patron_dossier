import 'character_builder.dart';
import 'stat_definition.dart';

const int _statBaseline = 20;
const int _statMin = 24;
const int _statMax = 38;
const int _jumpCost = 4;

CharacterBuilder incrementStat(CharacterBuilder builder, StatDefinition def) {
  final stats = builder.character.stats;
  final current = def.getter(stats);
  final points = builder.assignCharPoints ?? 0;

  if (current == _statBaseline && points >= _jumpCost) {
    return _withStat(builder, def, _statMin, points - _jumpCost);
  }
  if (current >= _statMin && current < _statMax && points >= 1) {
    return _withStat(builder, def, current + 1, points - 1);
  }
  return builder;
}

CharacterBuilder decrementStat(CharacterBuilder builder, StatDefinition def) {
  final stats = builder.character.stats;
  final current = def.getter(stats);
  final points = builder.assignCharPoints ?? 0;

  if (current == _statMin) {
    return _withStat(builder, def, _statBaseline, points + _jumpCost);
  }
  if (current > _statMin) {
    return _withStat(builder, def, current - 1, points + 1);
  }
  return builder;
}

CharacterBuilder _withStat(
  CharacterBuilder builder,
  StatDefinition def,
  int newValue,
  int newPoints,
) =>
    builder.copyWith(
      character: builder.character.copyWith(
        stats: def.updater(builder.character.stats, newValue),
      ),
      assignCharPoints: newPoints,
    );
