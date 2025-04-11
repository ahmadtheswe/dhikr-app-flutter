import 'dart:convert';

import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:dhikr_app/pages/dhikr_page.dart';
import 'package:dhikr_app/pages/settings_page.dart';
import 'package:dhikr_app/static/dhikr_time.dart';
import 'package:dhikr_app/static/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';
import '../shared/title/page_title.dart';

class DhikrListPage extends StatefulWidget {
  final String dhikrTime;

  const DhikrListPage({super.key, required this.dhikrTime});

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
    String jsonString = await rootBundle.loadString(
        'assets/dhikr/${widget.dhikrTime == DhikrTime.MORNING ? 'morning' : 'evening'}/dhikr_${widget.dhikrTime == DhikrTime.MORNING ? 'morning' : 'evening'}_${language == Languages.ENGLISH_CODE ? 'en' : 'id'}.json');

    final jsonResponse = json.decode(jsonString);
    List<Dhikr> dhikrs = (jsonResponse as List<dynamic>).map((item) => Dhikr.fromJson(item)).toList();

    setState(() {
      dhikr = dhikrs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    final listTextColor = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.blueGrey;

    return Scaffold(
        appBar: AppBar(
          title: PageTitle(text: languageService.getText(widget.dhikrTime == DhikrTime.MORNING ? 'morning' : 'evening')),
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
                              dhikrList: dhikr,
                              initialIndex: index,
                              isMorningDhikr: widget.dhikrTime == DhikrTime.MORNING,
                            )));
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withAlpha((0.5 * 255).toInt()),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  border: Border.all(
                    color: Theme.of(context).dividerColor.withAlpha((0.5 * 255).toInt()),
                    style: BorderStyle.solid,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${index + 1}. ${dhikr[index].title}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: listTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
