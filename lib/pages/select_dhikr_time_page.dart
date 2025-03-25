import 'package:dhikr_app/pages/dhikr_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';
import '../static/dhikr_time.dart';

class SelectDhikrTimePage extends StatefulWidget {
  const SelectDhikrTimePage({super.key});

  @override
  State<SelectDhikrTimePage> createState() => _SelectDhikrTimePage();
}

class _SelectDhikrTimePage extends State<SelectDhikrTimePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DhikrListPage(
                            dhikrTime: DhikrTime.MORNING,
                          )),
                );
              },
              child: Text(languageService.getText(DhikrTime.MORNING)),
            ),
            const SizedBox(height: 20), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DhikrListPage(
                            dhikrTime: DhikrTime.EVENING,
                          )),
                );
              },
              child: Text(languageService.getText(DhikrTime.EVENING)),
            ),
          ],
        ),
      ),
    );
  }
}
