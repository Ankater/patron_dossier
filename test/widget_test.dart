import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patron_dossier/features/characters/models/character_creation_mode.dart';
import 'package:patron_dossier/features/characters/screens/character_creation_screen.dart';
import 'package:patron_dossier/features/equipment/screens/weapon_list_screen.dart';
import 'package:patron_dossier/main.dart';

void main() {
  testWidgets('character list screen shows title and create button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PatronDossierApp());

    expect(find.text('Patron Dossier'), findsOneWidget);
    expect(find.text('Weapons'), findsOneWidget);
    expect(find.text('Create character'), findsOneWidget);
  });

  testWidgets('assign points screen shows point pool and stat labels',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterCreationScreen(mode: CharacterCreationMode.assignPoints),
    ));

    expect(find.textContaining('Assign points: 90'), findsOneWidget);
    for (final label in ['WS', 'BS', 'STR', 'TGH', 'AG', 'PER', 'WIL', 'FEL']) {
      expect(find.text(label), findsOneWidget, reason: '$label missing');
    }
  });

  testWidgets('roll stats screen shows reroll button and stat labels',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterCreationScreen(mode: CharacterCreationMode.rollStats),
    ));

    expect(find.text('Reroll'), findsOneWidget);
    for (final label in ['WS', 'BS', 'STR', 'TGH', 'AG', 'PER', 'WIL', 'FEL']) {
      expect(find.text(label), findsOneWidget, reason: '$label missing');
    }
  });

  testWidgets('pre-character create screen shows both mode options',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PatronDossierApp());
    await tester.tap(find.text('Create character'));
    await tester.pumpAndSettle();

    expect(find.text('Assign points'), findsOneWidget);
    expect(find.text('Roll stats'), findsOneWidget);
  });

  testWidgets('weapon list screen groups weapons by type and weapon group',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WeaponListScreen()));

    expect(find.text('Melee'), findsOneWidget);
    expect(find.text('Ranged'), findsOneWidget);
    expect(find.text('CHAIN WEAPONS'), findsOneWidget);
    expect(find.text('MUNDANE WEAPONS'), findsOneWidget);
    expect(find.text('LAS WEAPONS'), findsOneWidget);
    expect(find.text('GRENADES AND EXPLOSIVES'), findsOneWidget);
    expect(find.text('Chainaxe'), findsOneWidget);
    expect(find.text('Brass Knuckles'), findsOneWidget);
    expect(find.text('Las Carbine'), findsOneWidget);
  });

  testWidgets('main screen weapons button opens weapon list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PatronDossierApp());

    await tester.tap(find.text('Weapons'));
    await tester.pumpAndSettle();

    expect(find.text('CHAIN WEAPONS'), findsOneWidget);
    expect(find.text('Las Carbine'), findsOneWidget);
  });
}
