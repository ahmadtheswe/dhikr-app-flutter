import 'package:dhikr_app/pages/about_app_page.dart';
import 'package:dhikr_app/shared/button/language_elevated_button.dart';
import 'package:dhikr_app/shared/button/standard_elevated_button.dart';
import 'package:dhikr_app/shared/title/menu_title.dart';
import 'package:dhikr_app/static/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';
import '../shared/title/page_title.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          text: languageService.getText('settings'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: MenuTitle(text: languageService.getText('changeLanguage')),
            ),
            LanguageElevatedButton(
              languageTitle: Languages.INDONESIAN_TITLE,
              icon: Languages.INDONESIAN_ICON,
              onPressed: () async {
                await languageService.setLanguage(Languages.INDONESIAN_CODE);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            LanguageElevatedButton(
              languageTitle: Languages.ENGLISH_TITLE,
              icon: Languages.ENGLISH_ICON,
              onPressed: () async {
                await languageService.setLanguage(Languages.ENGLISH_CODE);
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: MenuTitle(text: languageService.getText('aboutUs')),
            ),
            StandardElevatedButton(
              text: languageService.getText('aboutTheApp'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutAppPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
