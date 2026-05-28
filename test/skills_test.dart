import 'package:flutter_test/flutter_test.dart';
import 'package:patron_dossier/features/characters/models/characteristic.dart';
import 'package:patron_dossier/features/characters/models/preset_skills.dart';
import 'package:patron_dossier/features/characters/models/skill.dart';

void main() {
  group('Skill model', () {
    const skill = Skill(
      name: 'Logic',
      characteristic: Characteristic.intel,
      specialisations: ['Evaluation', 'Investigation'],
    );

    test('copyWith updates values and preserves unspecified values', () {
      final updated = skill.copyWith(
        name: 'Awareness',
        characteristic: Characteristic.per,
        specialisations: const ['Awareness'],
      );

      expect(updated.name, 'Awareness');
      expect(updated.characteristic, Characteristic.per);
      expect(updated.specialisations, ['Awareness']);
    });

    test('copyWith preserves existing values', () {
      final updated = skill.copyWith();

      expect(updated.name, 'Logic');
      expect(updated.characteristic, Characteristic.intel);
      expect(updated.specialisations, ['Evaluation', 'Investigation']);
    });
  });

  group('CharacterSkill model', () {
    const skill = CharacterSkill(
      name: 'Stealth',
      characteristic: Characteristic.ag,
      specialisations: ['Hide'],
      advances: 2,
    );

    test('copyWith updates values and preserves unspecified values', () {
      final updated = skill.copyWith(
        name: 'Melee',
        characteristic: Characteristic.ws,
        specialisations: const ['Melee'],
        advances: 3,
      );

      expect(updated.name, 'Melee');
      expect(updated.characteristic, Characteristic.ws);
      expect(updated.specialisations, ['Melee']);
      expect(updated.advances, 3);
    });

    test('defaults advances to zero', () {
      const skill = CharacterSkill(
        name: 'Rapport',
        characteristic: Characteristic.fel,
      );

      expect(skill.advances, 0);
    });

    test('does not allow negative advances', () {
      expect(
        () => CharacterSkill(
          name: 'Discipline',
          characteristic: Characteristic.wil,
          advances: -1,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('CharacterSkillSpecialisation model', () {
    const baseSkill = Skill(
      name: 'Ranged',
      characteristic: Characteristic.bs,
      specialisations: ['Pistol', 'Long Gun'],
    );
    const specialisation = CharacterSkillSpecialisation(
      name: 'Pistol',
      skill: baseSkill,
      advances: 1,
    );

    test('copyWith updates values and preserves unspecified values', () {
      const newSkill = Skill(
        name: 'Tech',
        characteristic: Characteristic.intel,
      );
      final updated = specialisation.copyWith(
        name: 'Engineering',
        skill: newSkill,
        advances: 4,
      );

      expect(updated.name, 'Engineering');
      expect(updated.skill.characteristic, Characteristic.intel);
      expect(updated.advances, 4);
    });

    test('defaults advances to zero', () {
      const specialisation = CharacterSkillSpecialisation(
        name: 'Lore',
        skill: baseSkill,
      );

      expect(specialisation.advances, 0);
    });

    test('does not allow negative advances', () {
      expect(
        () => CharacterSkillSpecialisation(
          name: 'Pistol',
          skill: baseSkill,
          advances: -1,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('Preset skills', () {
    Skill skillNamed(String name) =>
        presetSkills.firstWhere((skill) => skill.name == name);

    test('contains all core skills', () {
      expect(presetSkills, hasLength(20));
    });

    test('uses unique names', () {
      final names = presetSkills.map((skill) => skill.name).toSet();

      expect(names, hasLength(presetSkills.length));
    });

    test('every skill has at least one specialisation', () {
      for (final skill in presetSkills) {
        expect(skill.specialisations, isNotEmpty, reason: skill.name);
      }
    });

    test('stores Athletics row', () {
      final skill = skillNamed('Athletics');

      expect(skill.characteristic, Characteristic.str);
      expect(skill.specialisations, [
        'Climbing',
        'Might',
        'Riding',
        'Running',
        'Swimming',
      ]);
    });

    test('stores Awareness row', () {
      final skill = skillNamed('Awareness');

      expect(skill.characteristic, Characteristic.per);
      expect(skill.specialisations, [
        'Sight',
        'Smell',
        'Hearing',
        'Taste',
        'Touch',
        'Psyniscience (Restricted)',
      ]);
    });

    test('stores Lore row', () {
      final skill = skillNamed('Lore');

      expect(skill.characteristic, Characteristic.intel);
      expect(skill.specialisations, [
        'Academics',
        'Adeptus Terra',
        'Planet',
        'Sector',
        'Theology (Restricted)',
        'Forbidden (Various, Restricted)',
      ]);
    });

    test('stores Piloting row', () {
      final skill = skillNamed('Piloting');

      expect(skill.characteristic, Characteristic.ag);
      expect(skill.specialisations, [
        'Aeronautica',
        'Civilian',
        'Personal Transports',
        'Military (Restricted)',
        'Minor Voidship (Restricted)',
        'Major Voidship (Restricted)',
      ]);
    });

    test('stores Tech row', () {
      final skill = skillNamed('Tech');

      expect(skill.characteristic, Characteristic.intel);
      expect(skill.specialisations, [
        'Augmetics (Restricted)',
        'Engineering',
        'Security',
      ]);
    });
  });
}
