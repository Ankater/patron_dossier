import 'package:flutter/material.dart';

import '../../equipment/screens/armour_list_screen.dart';
import '../../equipment/screens/augment_list_screen.dart';
import '../../equipment/screens/force_field_list_screen.dart';
import '../../equipment/screens/gear_list_screen.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const WeaponListScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.inventory_2_outlined),
                  label: const Text('Weapons'),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ArmourListScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.shield_outlined),
                  label: const Text('Armour'),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ForceFieldListScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.security_outlined),
                  label: const Text('Force Fields'),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const GearListScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.backpack_outlined),
                  label: const Text('Gear'),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AugmentListScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.settings_accessibility_outlined),
                  label: const Text('Augments'),
                ),
              ],
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
