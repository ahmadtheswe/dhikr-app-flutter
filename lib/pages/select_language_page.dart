import 'package:dhikr_app/pages/select_dhikr_time_page.dart';
import 'package:dhikr_app/shared/button/language_elevated_button.dart';
import 'package:dhikr_app/shared/title/menu_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';
import '../static/languages.dart';

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
            const MenuTitle(text: Languages.COMMON_SELECT_LANGUAGE),
            const SizedBox(height: 20), // Add some space between the buttons
            LanguageElevatedButton(
              languageTitle: Languages.INDONESIAN_TITLE,
              icon: Languages.INDONESIAN_ICON,
              onPressed: () async {
                final navigator = Navigator.of(context);
                await languageService.setLanguage(Languages.INDONESIAN_CODE);
                navigator.push(
                  MaterialPageRoute(builder: (context) => const SelectDhikrTimePage()),
                );
              },
            ),
            const SizedBox(height: 20), // Add some space between the buttons
            LanguageElevatedButton(
              languageTitle: Languages.ENGLISH_TITLE,
              icon: Languages.ENGLISH_ICON,
              onPressed: () async {
                final navigator = Navigator.of(context);
                await languageService.setLanguage(Languages.ENGLISH_CODE);
                navigator.push(
                  MaterialPageRoute(builder: (context) => const SelectDhikrTimePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
