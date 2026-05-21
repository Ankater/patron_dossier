import 'package:flutter/material.dart';

import 'pre_character_create_screen.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  static const _dummyCharacters = [
    'Cassius Varn',
    'Lyra Moritex',
    'Brother Aldric',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patron Dossier'),
      ),
      body: ListView.builder(
        itemCount: _dummyCharacters.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.person_outline),
          title: Text(_dummyCharacters[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const PreCharacterCreateScreen(),
          ),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Create character'),
      ),
    );
  }
}
