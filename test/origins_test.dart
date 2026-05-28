import 'package:flutter_test/flutter_test.dart';
import 'package:patron_dossier/features/characters/models/characteristic.dart';
import 'package:patron_dossier/features/characters/models/origin.dart';
import 'package:patron_dossier/features/characters/models/preset_origins.dart';
import 'package:patron_dossier/features/equipment/models/character_gear.dart';
import 'package:patron_dossier/features/equipment/models/weapon_availability.dart';

void main() {
  group('Characteristic', () {
    test('exposes labels matching stat definitions', () {
      expect(Characteristic.ws.label, 'WS');
      expect(Characteristic.bs.label, 'BS');
      expect(Characteristic.str.label, 'STR');
      expect(Characteristic.tgh.label, 'TGH');
      expect(Characteristic.ag.label, 'AG');
      expect(Characteristic.per.label, 'PER');
      expect(Characteristic.intel.label, 'INT');
      expect(Characteristic.wil.label, 'WIL');
      expect(Characteristic.fel.label, 'FEL');
    });

    test('has nine values', () {
      expect(Characteristic.values, hasLength(9));
    });
  });

  group('Origin model', () {
    const gear = CharacterGear(
      name: 'Test Item',
      enc: 1,
      cost: 50,
      availability: Availability.common,
      group: 'Tools',
      source: 'core book',
    );
    const origin = Origin(
      name: 'Test World',
      bonusCharacteristic: Characteristic.str,
      bonusSelectCharacteristic: [Characteristic.tgh, Characteristic.ag],
      characterGear: gear,
      source: 'core book',
    );

    test('copyWith updates name and preserves other fields', () {
      final updated = origin.copyWith(name: 'Other World');

      expect(updated.name, 'Other World');
      expect(updated.bonusCharacteristic, Characteristic.str);
      expect(updated.bonusSelectCharacteristic,
          [Characteristic.tgh, Characteristic.ag]);
      expect(updated.characterGear.name, 'Test Item');
      expect(updated.source, 'core book');
    });

    test('copyWith updates bonusCharacteristic', () {
      final updated = origin.copyWith(bonusCharacteristic: Characteristic.wil);

      expect(updated.bonusCharacteristic, Characteristic.wil);
      expect(updated.name, 'Test World');
    });

    test('copyWith updates bonusSelectCharacteristic', () {
      final updated = origin.copyWith(
        bonusSelectCharacteristic: [Characteristic.fel],
      );

      expect(updated.bonusSelectCharacteristic, [Characteristic.fel]);
    });

    test('copyWith updates characterGear', () {
      const newGear = CharacterGear(
        name: 'New Item',
        enc: 0,
        cost: 10,
        availability: Availability.common,
        group: 'Tools',
        source: 'core book',
      );
      final updated = origin.copyWith(characterGear: newGear);

      expect(updated.characterGear.name, 'New Item');
    });
  });

  group('Preset origins', () {
    Origin originNamed(String name) =>
        presetOrigins.firstWhere((o) => o.name == name);

    test('contains eight origins', () {
      expect(presetOrigins, hasLength(8));
    });

    test('uses unique names', () {
      final names = presetOrigins.map((o) => o.name).toSet();
      expect(names, hasLength(presetOrigins.length));
    });

    test('all origins have core book source', () {
      expect(presetOrigins.every((o) => o.source == 'core book'), isTrue);
    });

    test('each origin has exactly three bonusSelectCharacteristics', () {
      for (final origin in presetOrigins) {
        expect(
          origin.bonusSelectCharacteristic,
          hasLength(3),
          reason: origin.name,
        );
      }
    });

    test('bonusCharacteristic is not among bonusSelectCharacteristic', () {
      for (final origin in presetOrigins) {
        expect(
          origin.bonusSelectCharacteristic,
          isNot(contains(origin.bonusCharacteristic)),
          reason: origin.name,
        );
      }
    });

    test('stores Agri World row', () {
      final origin = originNamed('Agri World');

      expect(origin.bonusCharacteristic, Characteristic.str);
      expect(origin.bonusSelectCharacteristic, [
        Characteristic.tgh,
        Characteristic.ag,
        Characteristic.wil,
      ]);
      expect(origin.characterGear.name, 'Entrenching Tool');
      expect(origin.characterGear.flaws.single.name, 'Shoddy');
    });

    test('stores Feudal World row', () {
      final origin = originNamed('Feudal World');

      expect(origin.bonusCharacteristic, Characteristic.ws);
      expect(origin.bonusSelectCharacteristic, [
        Characteristic.str,
        Characteristic.wil,
        Characteristic.fel,
      ]);
      expect(origin.characterGear.name, 'Writing Kit');
      expect(origin.characterGear.flaws.single.name, 'Shoddy');
    });

    test('stores Feral World row', () {
      final origin = originNamed('Feral World');

      expect(origin.bonusCharacteristic, Characteristic.tgh);
      expect(origin.bonusSelectCharacteristic, [
        Characteristic.ws,
        Characteristic.str,
        Characteristic.per,
      ]);
      expect(origin.characterGear.name, 'Survival Gear');
      expect(origin.characterGear.flaws.single.name, 'Shoddy');
    });

    test('stores Forge World row', () {
      final origin = originNamed('Forge World');

      expect(origin.bonusCharacteristic, Characteristic.intel);
      expect(origin.bonusSelectCharacteristic, [
        Characteristic.bs,
        Characteristic.tgh,
        Characteristic.ag,
      ]);
      expect(origin.characterGear.name, 'Sacred Unguents (5 uses)');
      expect(origin.characterGear.flaws, isEmpty);
      expect(origin.characterGear.qualities, isEmpty);
    });

    test('stores Hive World row', () {
      final origin = originNamed('Hive World');

      expect(origin.bonusCharacteristic, Characteristic.ag);
      expect(origin.bonusSelectCharacteristic, [
        Characteristic.bs,
        Characteristic.per,
        Characteristic.fel,
      ]);
      expect(origin.characterGear.name, 'Filtration Plugs');
      expect(origin.characterGear.flaws.single.name, 'Ugly');
    });

    test('stores Shrine World row', () {
      final origin = originNamed('Shrine World');

      expect(origin.bonusCharacteristic, Characteristic.wil);
      expect(origin.bonusSelectCharacteristic, [
        Characteristic.intel,
        Characteristic.per,
        Characteristic.fel,
      ]);
      expect(origin.characterGear.name, 'Holy Icon');
      expect(origin.characterGear.flaws, isEmpty);
    });

    test('stores Schola Progenium row', () {
      final origin = originNamed('Schola Progenium');

      expect(origin.bonusCharacteristic, Characteristic.fel);
      expect(origin.bonusSelectCharacteristic, [
        Characteristic.ws,
        Characteristic.bs,
        Characteristic.tgh,
      ]);
      expect(origin.characterGear.name, 'Chrono');
      expect(origin.characterGear.flaws, isEmpty);
    });

    test('stores Voidborn row', () {
      final origin = originNamed('Voidborn');

      expect(origin.bonusCharacteristic, Characteristic.per);
      expect(origin.bonusSelectCharacteristic, [
        Characteristic.ag,
        Characteristic.intel,
        Characteristic.wil,
      ]);
      expect(origin.characterGear.name, 'Mag Boots');
      expect(origin.characterGear.flaws.single.name, 'Shoddy');
    });
  });
}
