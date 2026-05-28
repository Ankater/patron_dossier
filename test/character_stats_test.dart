import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:patron_dossier/features/characters/models/assign_points_logic.dart';
import 'package:patron_dossier/features/characters/models/character_blank_object.dart';
import 'package:patron_dossier/features/characters/models/character_builder.dart';
import 'package:patron_dossier/features/characters/models/character_stats.dart';
import 'package:patron_dossier/features/characters/models/dice_roller.dart';
import 'package:patron_dossier/features/characters/models/stat_definition.dart';

void main() {
  group('CharacterStats.copyWith', () {
    const base = CharacterStats();

    test('updates ws and preserves other fields', () {
      final updated = base.copyWith(ws: 30);
      expect(updated.ws, 30);
      expect(updated.bs, 20);
      expect(updated.str, 20);
      expect(updated.tgh, 20);
      expect(updated.ag, 20);
      expect(updated.per, 20);
      expect(updated.intel, 20);
      expect(updated.wil, 20);
      expect(updated.fel, 20);
    });

    test('updates bs', () => expect(base.copyWith(bs: 25).bs, 25));
    test('updates str', () => expect(base.copyWith(str: 28).str, 28));
    test('updates tgh', () => expect(base.copyWith(tgh: 31).tgh, 31));
    test('updates ag', () => expect(base.copyWith(ag: 22).ag, 22));
    test('updates per', () => expect(base.copyWith(per: 35).per, 35));
    test('updates intel', () => expect(base.copyWith(intel: 34).intel, 34));
    test('updates wil', () => expect(base.copyWith(wil: 38).wil, 38));
    test('updates fel', () => expect(base.copyWith(fel: 24).fel, 24));

    test('wil and fel are independent fields', () {
      final s = base.copyWith(wil: 30, fel: 35);
      expect(s.wil, 30);
      expect(s.fel, 35);
    });
  });

  group('Assign points — increment', () {
    // WS stat definition is the first in the list
    final def = statDefinitions.first;

    CharacterBuilder makeBuilder({int ws = 20, int points = 90}) =>
        CharacterBuilder(
          character: CharacterBlankObject(stats: CharacterStats(ws: ws)),
          assignCharPoints: points,
        );

    test('20 -> 24 costs 4 points', () {
      final result = incrementStat(makeBuilder(ws: 20, points: 90), def);
      expect(result.character.stats.ws, 24);
      expect(result.assignCharPoints, 86);
    });

    test('20 + increment is blocked when points < 4', () {
      final result = incrementStat(makeBuilder(ws: 20, points: 3), def);
      expect(result.character.stats.ws, 20);
      expect(result.assignCharPoints, 3);
    });

    test('24 -> 25 costs 1 point', () {
      final result = incrementStat(makeBuilder(ws: 24, points: 10), def);
      expect(result.character.stats.ws, 25);
      expect(result.assignCharPoints, 9);
    });

    test('37 -> 38 costs 1 point', () {
      final result = incrementStat(makeBuilder(ws: 37, points: 5), def);
      expect(result.character.stats.ws, 38);
      expect(result.assignCharPoints, 4);
    });

    test('38 + increment is blocked (stat ceiling)', () {
      final result = incrementStat(makeBuilder(ws: 38, points: 10), def);
      expect(result.character.stats.ws, 38);
    });
  });

  group('Assign points — decrement', () {
    final def = statDefinitions.first;

    CharacterBuilder makeBuilder({int ws = 20, int points = 86}) =>
        CharacterBuilder(
          character: CharacterBlankObject(stats: CharacterStats(ws: ws)),
          assignCharPoints: points,
        );

    test('24 -> 20 refunds 4 points', () {
      final result = decrementStat(makeBuilder(ws: 24, points: 86), def);
      expect(result.character.stats.ws, 20);
      expect(result.assignCharPoints, 90);
    });

    test('25 -> 24 refunds 1 point', () {
      final result = decrementStat(makeBuilder(ws: 25, points: 9), def);
      expect(result.character.stats.ws, 24);
      expect(result.assignCharPoints, 10);
    });

    test('38 -> 37 refunds 1 point', () {
      final result = decrementStat(makeBuilder(ws: 38, points: 0), def);
      expect(result.character.stats.ws, 37);
      expect(result.assignCharPoints, 1);
    });

    test('20 - decrement is blocked (stat floor)', () {
      final result = decrementStat(makeBuilder(ws: 20, points: 90), def);
      expect(result.character.stats.ws, 20);
    });
  });

  group('rollCharacterStats', () {
    test('all stats are in [22, 40]', () {
      for (var seed = 0; seed < 200; seed++) {
        final stats = rollCharacterStats(Random(seed));
        for (final def in statDefinitions) {
          final value = def.getter(stats);
          expect(value, greaterThanOrEqualTo(22),
              reason: '${def.label} was $value with seed $seed');
          expect(value, lessThanOrEqualTo(40),
              reason: '${def.label} was $value with seed $seed');
        }
      }
    });
  });

  group('CharacterBuilder exp', () {
    test('assign points mode initial exp is 0', () {
      const builder = CharacterBuilder(
        character: CharacterBlankObject(),
        assignCharPoints: 90,
        exp: 0,
      );
      expect(builder.exp, 0);
    });

    test('roll stats mode initial exp is 50', () {
      final builder = CharacterBuilder(
        character: CharacterBlankObject(stats: rollCharacterStats(Random(1))),
        exp: 50,
      );
      expect(builder.exp, 50);
    });

    test('pressing Switch stats subtracts 25 exp', () {
      const builder = CharacterBuilder(
        character: CharacterBlankObject(),
        exp: 50,
      );
      final after = builder.copyWith(exp: builder.exp - 25);
      expect(after.exp, 25);
    });

    test('pressing Reroll sets exp to 0', () {
      const builder = CharacterBuilder(
        character: CharacterBlankObject(),
        exp: 25,
      );
      final after = builder.copyWith(exp: 0);
      expect(after.exp, 0);
    });

    test('copyWith preserves exp when not specified', () {
      const builder = CharacterBuilder(
        character: CharacterBlankObject(),
        exp: 35,
      );
      final after = builder.copyWith(assignCharPoints: 5);
      expect(after.exp, 35);
    });
  });

  group('StatDefinitions', () {
    test('FEL uses CharacterStats.fel, not wil', () {
      final felDef = statDefinitions.last;
      expect(felDef.label, 'FEL');
      const stats = CharacterStats(wil: 30, fel: 35);
      expect(felDef.getter(stats), 35);
    });

    test('WIL uses CharacterStats.wil, not fel', () {
      final wilDef = statDefinitions[statDefinitions.length - 2];
      expect(wilDef.label, 'WIL');
      const stats = CharacterStats(wil: 30, fel: 35);
      expect(wilDef.getter(stats), 30);
    });

    test('INTEL uses CharacterStats.intel', () {
      final intelDef = statDefinitions[6];
      expect(intelDef.label, 'INT');
      const stats = CharacterStats(intel: 33);
      expect(intelDef.getter(stats), 33);
    });
  });
}
