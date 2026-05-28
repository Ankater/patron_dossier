import 'package:flutter/material.dart';

import '../models/character_creation_mode.dart';
import 'character_creation_screen.dart';

class PreCharacterCreateScreen extends StatelessWidget {
  const PreCharacterCreateScreen({super.key});

  void _navigate(BuildContext context, CharacterCreationMode mode) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CharacterCreationScreen(mode: mode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Character'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose a creation stats method',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                icon: const Icon(Icons.edit_note),
                label: const Text('Assign points'),
                onPressed: () =>
                    _navigate(context, CharacterCreationMode.assignPoints),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.casino),
                label: const Text('Roll stats'),
                onPressed: () =>
                    _navigate(context, CharacterCreationMode.rollStats),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
