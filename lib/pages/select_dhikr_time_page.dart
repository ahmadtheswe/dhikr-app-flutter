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
            _createElevatedButton(DhikrTime.MORNING, languageService),// Add some space between the buttons
            const SizedBox(height: 20),
            _createElevatedButton(DhikrTime.EVENING, languageService),// Add some space between the buttons
          ],
        ),
      ),
    );
  }

  Widget _createElevatedButton(String dhikrTime, LanguageService languageService) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: const Size(250, 60)),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DhikrListPage(
                      dhikrTime: dhikrTime,
                    )),
          );
        },
        child: Text(languageService.getText(dhikrTime)));
  }
}
