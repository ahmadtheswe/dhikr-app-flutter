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
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(languageService.getText('changeLanguage'), style: const TextStyle(fontSize: 20,)),
            ),
            _createElevatedButton(Languages.INDONESIAN_TITLE, Languages.INDONESIAN_CODE, context, languageService, 'icons/flags/png100px/id.png'),
            const SizedBox(
              height: 20,
            ),
            _createElevatedButton(Languages.ENGLISH_TITLE, Languages.ENGLISH_CODE, context, languageService, 'icons/flags/png100px/gb.png'),
          ],
        ),
      ),
    );
  }

  Widget _createElevatedButton(String languageTitle, String languageCode, BuildContext context, LanguageService languageService, String icon) {
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
}
