import 'package:flutter/material.dart';

import '../../equipment/screens/weapon_list_screen.dart';
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const WeaponListScreen(),
                ),
              ),
              icon: const Icon(Icons.inventory_2_outlined),
              label: const Text('Weapons'),
            ),
          ),
          for (final character in _dummyCharacters)
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(character),
            ),
        ],
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
