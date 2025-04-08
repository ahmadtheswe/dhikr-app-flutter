import 'package:dhikr_app/shared/button/standard_elevated_button.dart';
import 'package:dhikr_app/shared/title/page_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPage();
}

class _AboutAppPage extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
        appBar: AppBar(
          title: PageTitle(
            text: languageService.getText('aboutTheApp'),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(languageService.getText('aboutUsText'),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 17,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(languageService.getText('aboutTheDeveloper'),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 17,
                  )),
              const SizedBox(
                height: 20,
              ),
              StandardElevatedButton(
                text: languageService.getText('privacyPolicy'),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
