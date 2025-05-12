import 'package:dhikr_app/pages/dhikr_list_page.dart';
import 'package:dhikr_app/pages/set_alarm_page.dart';
import 'package:dhikr_app/shared/button/select_dhikr_elevated_button.dart';
import 'package:dhikr_app/shared/button/setting_button.dart';
import 'package:dhikr_app/shared/title/menu_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';
import '../shared/button/standard_elevated_button.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          SettingButton(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              MenuTitle(text: languageService.getText('selectDhikrTime')),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectDhikrElevatedButton(
                    dhikrTime: DhikrTime.MORNING,
                    text: languageService.getText(DhikrTime.MORNING),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DhikrListPage(
                                  dhikrTime: DhikrTime.MORNING,
                                )),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  SelectDhikrElevatedButton(
                    dhikrTime: DhikrTime.EVENING,
                    text: languageService.getText(DhikrTime.EVENING),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DhikrListPage(
                                  dhikrTime: DhikrTime.EVENING,
                                )),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 70),
              MenuTitle(
                text: languageService.getText('setYourAlarmsText'),
              ),
              StandardElevatedButton(
                text: languageService.getText('setYourAlarms'),
                icon: Icons.alarm,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SetAlarmPage()),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          )
        ],
      ),
    );
  }
}
