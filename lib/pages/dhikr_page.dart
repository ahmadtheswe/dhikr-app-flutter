import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:flutter/material.dart';

class DhikrPage extends StatelessWidget {
  const DhikrPage({super.key, required this.dhikr});

  final Dhikr dhikr;

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(fontSize: 25),
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
}
