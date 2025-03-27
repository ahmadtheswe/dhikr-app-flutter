import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';

class DhikrPage extends StatefulWidget {
  const DhikrPage({super.key, required this.dhikrList, required this.initialIndex});

  final List<Dhikr> dhikrList;
  final int initialIndex;

  @override
  State<DhikrPage> createState() => _DhikrPage();
}

class _DhikrPage extends State<DhikrPage> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _goToFirst() {
    setState(() => currentIndex = 0);
  }

  void _goToPrevious() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  void _goToNext() {
    if (currentIndex < widget.dhikrList.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void _goToLast() {
    setState(() => currentIndex = widget.dhikrList.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final Dhikr dhikr = widget.dhikrList[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(dhikr.title),
      ),
      body: ListView(
        children: [
          _arabicText(dhikr.arabicText),
          const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20, color: Colors.grey),
          if (dhikr.pronounceText != null) ...[
            _latinText(dhikr.pronounceText!),
            const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20, color: Colors.grey),
          ],
          _latinText(dhikr.indonesianTranslation),
          if (dhikr.references.isNotEmpty) ...[
            const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20, color: Colors.grey),
            _referenceText(dhikr.references),
          ]
        ],
      ),
      bottomNavigationBar: _buttonAppBar(languageService, currentIndex + 1, widget.dhikrList.length),
    );
  }

  _arabicText(String text) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 25,
              fontFamily: 'Amiri',
            ),
          ),
        ));
  }

  _latinText(String text) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 17),
          ),
        ));
  }

  _referenceText(List<String> texts) {
    if (texts.length == 1) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10),
        child: Text(
          texts[0],
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 15),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: texts.map((ref) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('\u2022 ', style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: Text(
                      ref,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  _buttonAppBar(LanguageService languageService, int currentIndex, int length) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.keyboard_double_arrow_left),
              onPressed: currentIndex > 1 ? _goToFirst : null,
              tooltip: languageService.getText('first'),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: currentIndex > 1 ? _goToPrevious : null,
              tooltip: languageService.getText('previous'),
            ),
            Text('$currentIndex/$length'),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: currentIndex < widget.dhikrList.length ? _goToNext : null,
              tooltip: languageService.getText('next'),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_double_arrow_right),
              onPressed: currentIndex < widget.dhikrList.length ? _goToLast : null,
              tooltip: languageService.getText('last'),
            ),
          ],
        ),
      ),
    );
  }
}
