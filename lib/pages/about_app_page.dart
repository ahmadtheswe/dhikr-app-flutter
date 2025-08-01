import 'package:dhikr_app/shared/button/leading_back_button.dart';
import 'package:dhikr_app/shared/button/standard_elevated_button.dart';
import 'package:dhikr_app/shared/text/application_version.dart';
import 'package:dhikr_app/shared/title/page_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
          leading: const LeadingBackButton(),
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
                onPressed: _launchURL,
              ),
              const SizedBox(
                height: 20,
              ),
              const ApplicationVersion(),
            ],
          ),
        ));
  }

  _launchURL() async {
    try {
      final Uri url = Uri.parse('https://ahmadtheswe.github.io/privacy-policy');
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
