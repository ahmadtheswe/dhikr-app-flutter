import 'dart:convert';

import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:dhikr_app/pages/dhikr_page.dart';
import 'package:dhikr_app/pages/settings_page.dart';
import 'package:dhikr_app/static/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';

class DhikrListPage extends StatefulWidget {
  const DhikrListPage({super.key});

  @override
  State<DhikrListPage> createState() => _DhikrListPage();
}

class _DhikrListPage extends State<DhikrListPage> {
  List<Dhikr> dhikr = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDhikr();
  }

  Future<void> loadDhikr() async {
    final languageService = context.watch<LanguageService>(); // Listen for language changes
    String? language = languageService.currentLanguage;
    String jsonString = language == Languages.ENGLISH
        ? await rootBundle.loadString('lib/assets/morning_en.json')
        : await rootBundle.loadString('lib/assets/morning_id.json');
    final jsonResponse = json.decode(jsonString);
    List<Dhikr> dhikrs = (jsonResponse as List<dynamic>).map((item) => Dhikr.fromJson(item)).toList();

    setState(() {
      dhikr = dhikrs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(languageService.getText('listPageTitle')),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: dhikr.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DhikrPage(
                              dhikr: dhikr[index],
                            )));
                // loadDhikr(); // Reload data after returning from settings
              },
              child: Container(
                height: 65,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dhikr[index].title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
