import 'package:dhikr_app/pages/dhikr_list_page.dart';
import 'package:dhikr_app/static/languages.dart';
import 'package:dhikr_app/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<StatefulWidget> createState() => _SelectLanguage();
}

class _SelectLanguage extends State<SelectLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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