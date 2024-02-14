import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:flutter/cupertino.dart';
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
          if (dhikr.pronounceText != null) _latinText(dhikr.pronounceText!),
          _latinText(dhikr.indonesianTranslation),
        ],
      ),
    );
  }
  
  _arabicText(String text) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 25),
          ),
        )
    );
  }
  
  _latinText(String text) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 17),
          ),
        )
    );
  }
}
