import 'package:flutter/material.dart';

import 'features/characters/screens/character_list_screen.dart';

void main() {
  runApp(const PatronDossierApp());
}

class PatronDossierApp extends StatelessWidget {
  const PatronDossierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patron Dossier',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const CharacterListScreen(),
    );
  }
}
