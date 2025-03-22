import 'package:dhikr_app/pages/dhikr_list_page.dart';
import 'package:dhikr_app/static/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await languageService.setLanguage(Languages.INDONESIAN);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DhikrListPage()),
                );
              },
              child: const Text('Bahasa Indonesia'),
            ),
            const SizedBox(height: 20), // Add some space between the buttons
            ElevatedButton(
              onPressed: () async {
                await languageService.setLanguage(Languages.ENGLISH);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DhikrListPage()),
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
