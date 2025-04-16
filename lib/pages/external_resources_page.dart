import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/language_service.dart';
import '../shared/title/page_title.dart';

class ExternalResourcesPage extends StatelessWidget {
  const ExternalResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          text: languageService.getText('externalResources'),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('icons8.com - Morning Icon'),
            onTap: () {
              launchUrl(Uri.parse('https://icons8.com/icon/qs7i2xsN6JHA/morning'));
            },
          ),
          ListTile(
            title: const Text('icons8.com - Evening Icon'),
            onTap: () {
              launchUrl(Uri.parse('https://icons8.com/icon/51h6hCtYiKnV/evening'));
            },
          ),
        ],
      ),
    );
  }
}
