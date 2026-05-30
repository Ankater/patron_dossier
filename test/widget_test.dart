import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patron_dossier/features/characters/models/character_blank_object.dart';
import 'package:patron_dossier/features/characters/models/character_builder.dart';
import 'package:patron_dossier/features/characters/models/character_creation_mode.dart';
import 'package:patron_dossier/features/characters/screens/character_creation_screen.dart';
import 'package:patron_dossier/features/characters/screens/origins_screen.dart';
import 'package:patron_dossier/features/equipment/screens/armour_list_screen.dart';
import 'package:patron_dossier/features/equipment/screens/augment_list_screen.dart';
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
    expect(find.text('Augments'), findsOneWidget);
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

  testWidgets('assign points screen shows disabled Origin button initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterCreationScreen(mode: CharacterCreationMode.assignPoints),
    ));

    expect(find.text('Origin'), findsOneWidget);
    final btn = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Origin'),
    );
    expect(btn.onPressed, isNull);
  });

  testWidgets('roll stats screen shows enabled Origin button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterCreationScreen(mode: CharacterCreationMode.rollStats),
    ));

    expect(find.text('Origin'), findsOneWidget);
    final btn = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Origin'),
    );
    expect(btn.onPressed, isNotNull);
  });

  testWidgets('roll stats Origin button navigates to OriginsScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterCreationScreen(mode: CharacterCreationMode.rollStats),
    ));

    await tester.tap(find.text('Origin'));
    await tester.pumpAndSettle();

    expect(find.byType(OriginsScreen), findsOneWidget);
  });

  testWidgets('origins screen shows all origin names and stat grid',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OriginsScreen(
        builder: const CharacterBuilder(
          character: CharacterBlankObject(),
          exp: 50,
        ),
        onComplete: (_) {},
      ),
    ));

    for (final name in [
      'Agri World',
      'Feudal World',
      'Feral World',
      'Forge World',
      'Hive World',
      'Shrine World',
      'Schola Progenium',
      'Voidborn',
    ]) {
      expect(find.text(name), findsOneWidget, reason: '$name missing');
    }
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
      expect(find.text(label), findsOneWidget,
          reason: '$label missing in grid');
    }
  });

  testWidgets('origins screen shows roll origin button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OriginsScreen(
        builder: const CharacterBuilder(
          character: CharacterBlankObject(),
          exp: 50,
        ),
        onComplete: (_) {},
      ),
    ));

    expect(find.text('Roll origin  (+25 EXP)'), findsOneWidget);
  });

  testWidgets('origins screen selecting an origin shows 3 bonus chips',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OriginsScreen(
        builder: const CharacterBuilder(
          character: CharacterBlankObject(),
          exp: 50,
        ),
        onComplete: (_) {},
      ),
    ));

    await tester.tap(find.text('Agri World'));
    await tester.pumpAndSettle();

    expect(find.byType(ChoiceChip), findsNWidgets(3));
    final confirmBtn = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Confirm'),
    );
    expect(confirmBtn.onPressed, isNull);
  });

  testWidgets('origins screen confirm enabled after choosing bonus',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OriginsScreen(
        builder: const CharacterBuilder(
          character: CharacterBlankObject(),
          exp: 50,
        ),
        onComplete: (_) {},
      ),
    ));

    await tester.tap(find.text('Agri World'));
    await tester.pumpAndSettle();
    // Agri World bonus choices: TGH, AG, WIL — tap the first chip
    await tester.tap(find.byType(ChoiceChip).first);
    await tester.pumpAndSettle();

    final confirmBtn = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Confirm'),
    );
    expect(confirmBtn.onPressed, isNotNull);
  });

  testWidgets('origins screen change origin returns to origin list',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OriginsScreen(
        builder: const CharacterBuilder(
          character: CharacterBlankObject(),
          exp: 50,
        ),
        onComplete: (_) {},
      ),
    ));

    await tester.tap(find.text('Agri World'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Change origin'));
    await tester.pumpAndSettle();

    expect(find.text('Agri World'), findsOneWidget);
    expect(find.text('Voidborn'), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNothing);
  });

  testWidgets('origins screen roll button selects an origin',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OriginsScreen(
        builder: const CharacterBuilder(
          character: CharacterBlankObject(),
          exp: 50,
        ),
        onComplete: (_) {},
      ),
    ));

    await tester.tap(find.text('Roll origin  (+25 EXP)'));
    await tester.pumpAndSettle();

    // Any origin will show exactly 3 bonus chips
    expect(find.byType(ChoiceChip), findsNWidgets(3));
    expect(find.text('Change origin'), findsOneWidget);
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

  testWidgets('augment list screen shows replacements and augments tables',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AugmentListScreen()));

    expect(find.text('AUGMETIC REPLACEMENTS'), findsOneWidget);
    expect(find.text('AUGMETICS'), findsOneWidget);
    expect(find.text('Slot'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
    expect(find.text('Features'), findsWidgets);
    expect(find.text('Augmetic Arm'), findsOneWidget);
    expect(find.text('Augmetic Heart'), findsOneWidget);
    expect(find.text('Augur Array'), findsOneWidget);
    expect(find.text('Mind Impulse Unit'), findsOneWidget);
  });

  testWidgets('main screen augments button opens augments list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PatronDossierApp());

    await tester.tap(find.text('Augments'));
    await tester.pumpAndSettle();

    expect(find.text('AUGMETIC REPLACEMENTS'), findsOneWidget);
    expect(find.text('Augmetic Arm'), findsOneWidget);
    expect(find.text('Augur Array'), findsOneWidget);
  });
}
