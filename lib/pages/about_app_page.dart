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
        title: Text(languageService.getText('aboutTheApp')),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(languageService.getText('aboutUsText'),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 17,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(languageService.getText('aboutTheDeveloper'),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 17,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
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
              ))
        ],
      ),
    );
  }
}
