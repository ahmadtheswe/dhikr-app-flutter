import 'dart:convert';

import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:dhikr_app/pages/dhikr_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DhikrListPage extends StatefulWidget {
  const DhikrListPage({super.key, required this.title});
  final String title;

  @override
  State<DhikrListPage> createState() => _DhikrListPage();
}

class _DhikrListPage extends State<DhikrListPage> {
  List<Dhikr> dhikr = [];

  @override
  void initState() {
    super.initState();
    loadDhikr().then((value) {
      setState(() {
        dhikr = value;
      });
    });
  }

  Future<List<Dhikr>> loadDhikr() async {
    String jsonString = await rootBundle.loadString('lib/assets/morning.json');
    final jsonResponse = json.decode(jsonString);
    List<Dhikr> dhikrs = [];
    for (var i in jsonResponse) {
      dhikrs.add(Dhikr.fromJson(i));
    }
    return dhikrs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: dhikr.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DhikrPage(dhikr: dhikr[index],)));
              },
              child: Container(
                height: 65,
                margin: const EdgeInsets.all(10),
                color: Colors.cyanAccent,
                child: Center(
                  child: Text(
                    dhikr[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ));
  }
}