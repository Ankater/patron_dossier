import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patron_dossier/features/characters/models/character_creation_mode.dart';
import 'package:patron_dossier/features/characters/screens/character_creation_screen.dart';
import 'package:patron_dossier/features/equipment/screens/armour_list_screen.dart';
import 'package:patron_dossier/features/equipment/screens/force_field_list_screen.dart';
import 'package:patron_dossier/features/equipment/screens/gear_list_screen.dart';
import 'package:patron_dossier/features/equipment/screens/weapon_list_screen.dart';
import 'package:patron_dossier/main.dart';

void main() {
  testWidgets('character list screen shows title and create button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PatronDossierApp());

    expect(find.text('Patron Dossier'), findsOneWidget);
    expect(find.text('Weapons'), findsOneWidget);
    expect(find.text('Armour'), findsOneWidget);
    expect(find.text('Force Fields'), findsOneWidget);
    expect(find.text('Gear'), findsOneWidget);
    expect(find.text('Create character'), findsOneWidget);
  });

  testWidgets('assign points screen shows point pool and stat labels',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterCreationScreen(mode: CharacterCreationMode.assignPoints),
    ));

    expect(find.textContaining('Assign points: 90'), findsOneWidget);
    for (final label in [
      'WS',
      'BS',
      'STR',
      'TGH',
      'AG',
      'PER',
      'INT',
      'WIL',
      'FEL',
    ]) {
      expect(find.text(label), findsOneWidget, reason: '$label missing');
    }
  });

  testWidgets('roll stats screen shows reroll button and stat labels',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterCreationScreen(mode: CharacterCreationMode.rollStats),
    ));

    expect(find.text('Reroll'), findsOneWidget);
    for (final label in [
      'WS',
      'BS',
      'STR',
      'TGH',
      'AG',
      'PER',
      'INT',
      'WIL',
      'FEL',
    ]) {
      expect(find.text(label), findsOneWidget, reason: '$label missing');
    }
  });

  testWidgets('roll stats switch button enables draggable stat list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterCreationScreen(mode: CharacterCreationMode.rollStats),
    ));

    await tester.tap(find.text('Switch stats  (costs 25 EXP)'));
    await tester.pumpAndSettle();

    expect(find.text('EXP: 25'), findsOneWidget);
    expect(find.text('Drag stats to switch values'), findsOneWidget);
    expect(find.byType(ReorderableDragStartListener), findsWidgets);
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

  testWidgets('armour list screen groups armours by armour group',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ArmourListScreen()));

    expect(find.text('BASIC'), findsOneWidget);
    expect(find.text('FLAK'), findsOneWidget);
    expect(find.text('MESH'), findsOneWidget);
    expect(find.text('CARAPACE'), findsOneWidget);
    expect(find.text('POWER'), findsOneWidget);
    expect(find.text('Robes/Light Leathers'), findsOneWidget);
    expect(find.text('Combat Shield'), findsOneWidget);
    expect(find.text('Astra Militarum Flak Armour'), findsOneWidget);
  });

  testWidgets('armour list screen formats table values',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ArmourListScreen()));

    expect(find.text('Locations'), findsWidgets);
    expect(find.text('Armour'), findsWidgets);
    expect(find.text('Availability'), findsWidgets);
    expect(find.text('Arms, Body, Legs'), findsWidgets);
    expect(find.text('Special'), findsWidgets);
    expect(find.text('All'), findsWidgets);
    expect(find.text('Shield (2)'), findsOneWidget);
  });

  testWidgets('main screen armour button opens armour list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PatronDossierApp());

    await tester.tap(find.text('Armour'));
    await tester.pumpAndSettle();

    expect(find.text('BASIC'), findsOneWidget);
    expect(find.text('Combat Shield'), findsOneWidget);
  });

  testWidgets('force fields list screen shows preset force fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ForceFieldListScreen()));

    expect(find.text('Force Fields'), findsOneWidget);
    expect(find.text('Protection'), findsOneWidget);
    expect(find.text('Overload'), findsOneWidget);
    expect(find.text('Refractor Field'), findsOneWidget);
    expect(find.text('Conversion Field'), findsOneWidget);
    expect(find.text('1d10'), findsOneWidget);
    expect(find.text('2d10'), findsOneWidget);
  });

  testWidgets('main screen force fields button opens force fields list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PatronDossierApp());

    await tester.tap(find.text('Force Fields'));
    await tester.pumpAndSettle();

    expect(find.text('Refractor Field'), findsOneWidget);
    expect(find.text('Conversion Field'), findsOneWidget);
  });

  testWidgets('gear list screen groups gear by table header',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GearListScreen()));

    expect(find.text('TOOLS'), findsOneWidget);
    expect(find.text('CLOTHING AND PERSONAL GEAR'), findsOneWidget);
    expect(find.text('Auspex/Scanner'), findsOneWidget);
    expect(find.text('Disguise Kit'), findsOneWidget);
    expect(find.text('Backpack/Slings'), findsOneWidget);
    expect(find.text('Void Suit'), findsOneWidget);
    expect(find.text('Very Rare'), findsOneWidget);
  });

  testWidgets('main screen gear button opens gear list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PatronDossierApp());

    await tester.tap(find.text('Gear'));
    await tester.pumpAndSettle();

    expect(find.text('TOOLS'), findsOneWidget);
    expect(find.text('Auspex/Scanner'), findsOneWidget);
  });
}
