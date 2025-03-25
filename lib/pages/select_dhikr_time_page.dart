import 'package:dhikr_app/pages/dhikr_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';
import '../static/dhikr_time.dart';

class SelectDhikrTimePage extends StatelessWidget {
  const SelectDhikrTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context, listen: false);

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
              child: Text(languageService.getText("morning")),
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
              child: Text(languageService.getText("evening")),
            ),
          ],
        ),
      ),
    );
  }
}
