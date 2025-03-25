import 'package:dhikr_app/pages/select_dhikr_time_page.dart';
import 'package:country_icons/country_icons.dart';
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
            _createElevatedButton(Languages.INDONESIAN_TITLE, Languages.INDONESIAN_CODE, context, languageService, 'icons/flags/png100px/id.png'),
            const SizedBox(height: 20), // Add some space between the buttons
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SelectDhikrTimePage()),
          );
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
