import 'character_stats.dart';

class StatDefinition {
  StatDefinition({
    required this.label,
    required this.getter,
    required this.updater,
  });

  final String label;
  final int Function(CharacterStats) getter;
  final CharacterStats Function(CharacterStats, int) updater;
}

final List<StatDefinition> statDefinitions = [
  StatDefinition(
      label: 'WS', getter: (s) => s.ws, updater: (s, v) => s.copyWith(ws: v)),
  StatDefinition(
      label: 'BS', getter: (s) => s.bs, updater: (s, v) => s.copyWith(bs: v)),
  StatDefinition(
      label: 'STR',
      getter: (s) => s.str,
      updater: (s, v) => s.copyWith(str: v)),
  StatDefinition(
      label: 'TGH',
      getter: (s) => s.tgh,
      updater: (s, v) => s.copyWith(tgh: v)),
  StatDefinition(
      label: 'AG', getter: (s) => s.ag, updater: (s, v) => s.copyWith(ag: v)),
  StatDefinition(
      label: 'PER',
      getter: (s) => s.per,
      updater: (s, v) => s.copyWith(per: v)),
  StatDefinition(
      label: 'WIL',
      getter: (s) => s.wil,
      updater: (s, v) => s.copyWith(wil: v)),
  StatDefinition(
      label: 'FEL',
      getter: (s) => s.fel,
      updater: (s, v) => s.copyWith(fel: v)),
];
