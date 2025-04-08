import 'package:dhikr_app/pages/about_app_page.dart';
import 'package:dhikr_app/static/languages.dart';
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
        title: Text(languageService.getText('settings')),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(languageService.getText('changeLanguage'),
                  style: const TextStyle(
                    fontSize: 20,
                  )),
            ),
            _createLanguageSelectElevatedButton(Languages.INDONESIAN_TITLE, Languages.INDONESIAN_CODE, context, languageService, 'icons/flags/png100px/id.png'),
            const SizedBox(
              height: 20,
            ),
            _createLanguageSelectElevatedButton(Languages.ENGLISH_TITLE, Languages.ENGLISH_CODE, context, languageService, 'icons/flags/png100px/gb.png'),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(languageService.getText('aboutUs'),
                  style: const TextStyle(
                    fontSize: 20,
                  )),
            ),
            _createAboutTheAppElevatedButton(context, languageService),
          ],
        ),
      ),
    );
  }

  Widget _createLanguageSelectElevatedButton(String languageTitle, String languageCode, BuildContext context, LanguageService languageService, String icon) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: const Size(250, 60)),
        onPressed: () async {
          await languageService.setLanguage(languageCode);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(languageTitle),
            const SizedBox(width: 10),
            ClipOval(
              child: Image.asset(
                icon,
                package: 'country_icons',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            )
          ],
        ));
  }

  Widget _createAboutTheAppElevatedButton(BuildContext context, LanguageService languageService) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: const Size(250, 60)),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutAppPage()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(languageService.getText('aboutTheApp')),
            const SizedBox(width: 10),
          ],
        ));
  }
}
