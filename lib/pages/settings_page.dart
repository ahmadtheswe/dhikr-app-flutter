import 'package:flutter/material.dart';

import '../static/languages.dart';
import '../utils/user_preferences.dart';
import 'dhikr_list_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: FutureBuilder<String?>(
          future: UserPreferences.getLanguage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == Languages.ENGLISH) {
                return const Text(Languages.ENGLISH_SETTINGS);
              } else {
                return const Text(Languages.INDONESIAN_SETTINGS);
              }
            } else {
              return const Text('Select Language');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Add your onClick action here
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                UserPreferences.setLanguage(Languages.INDONESIAN);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DhikrListPage(title: 'Bahasa Indonesia')),
                );
              },
              child: const Text('Bahasa Indonesia'),
            ),
            const SizedBox(height: 20), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                UserPreferences.setLanguage(Languages.ENGLISH);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DhikrListPage(title: 'English')),
                );
              },
              child: const Text('English'),
            ),
          ],
        ),
      ),
    );
  }

}