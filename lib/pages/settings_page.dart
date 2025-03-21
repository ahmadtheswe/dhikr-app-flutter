import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';

class SettingsPage extends StatelessWidget {

  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(languageService.getText('settings')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await languageService.setLanguage('id');
              },
              child: const Text('Bahasa Indonesia'),
            ),
            const SizedBox(height: 20), // Add some space between the buttons
            ElevatedButton(
              onPressed: () async {
                await languageService.setLanguage('en');
              },
              child: const Text('English'),
            ),
          ],
        ),
      ),
    );
  }
}