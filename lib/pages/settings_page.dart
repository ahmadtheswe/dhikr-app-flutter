import 'package:dhikr_app/pages/about_app_page.dart';
import 'package:dhikr_app/pages/external_resources_page.dart';
import 'package:dhikr_app/service/alarm_service.dart';
import 'package:dhikr_app/shared/button/language_elevated_button.dart';
import 'package:dhikr_app/shared/button/leading_back_button.dart';
import 'package:dhikr_app/shared/button/standard_elevated_button.dart';
import 'package:dhikr_app/shared/title/menu_title.dart';
import 'package:dhikr_app/static/languages.dart';
import 'package:dhikr_app/widget/alarm_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';
import '../service/notification_service.dart';
import '../service/theme_service.dart';
import '../service/wake_lock_service.dart';
import '../shared/title/page_title.dart';
import '../static/dhikr_time.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final alarmService = Provider.of<AlarmService>(context);
    final themeService = Provider.of<ThemeService>(context);
    final wakeUpService = Provider.of<WakeLockService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const LeadingBackButton(),
        title: PageTitle(
          text: languageService.getText('settings'),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                MenuTitle(text: languageService.getText('changeLanguage'), icon: Icons.language),
                LanguageElevatedButton(
                  languageTitle: Languages.ENGLISH_TITLE,
                  icon: Languages.ENGLISH_ICON,
                  onPressed: () async {
                    await languageService.setLanguage(Languages.ENGLISH_CODE);
                    setDhikrAlarmTimeFromCache(alarmService, languageService, DhikrTime.MORNING, 1);
                    setDhikrAlarmTimeFromCache(alarmService, languageService, DhikrTime.EVENING, 2);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                LanguageElevatedButton(
                  languageTitle: Languages.INDONESIAN_TITLE,
                  icon: Languages.INDONESIAN_ICON,
                  onPressed: () async {
                    await languageService.setLanguage(Languages.INDONESIAN_CODE);
                    setDhikrAlarmTimeFromCache(alarmService, languageService, DhikrTime.MORNING, 1);
                    setDhikrAlarmTimeFromCache(alarmService, languageService, DhikrTime.EVENING, 2);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                MenuTitle(text: languageService.getText('darkMode'), icon: Icons.dark_mode),
                Switch(
                  value: themeService.isDarkMode(context),
                  onChanged: (isDark) {
                    themeService.toggleTheme(isDark);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                MenuTitle(text: languageService.getText('wakeLockMode'), icon: Icons.lightbulb_circle),
                Switch(
                  value: wakeUpService.isWakeUpEnabled,
                  onChanged: (isWakeUp) {
                    wakeUpService.toggleWakeUp(isWakeUp);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                MenuTitle(text: languageService.getText('alarmTitle') , icon: Icons.alarm),
                AlarmWidget(
                  morningTime: alarmService.getAlarmValueTimeOfDay(DhikrTime.MORNING),
                  eveningTime: alarmService.getAlarmValueTimeOfDay(DhikrTime.EVENING),
                  onMorningTimeChanged: (newTime) async {
                    setDhikrAlarmTime(newTime, alarmService, languageService, DhikrTime.MORNING, 1);
                  },
                  onEveningTimeChanged: (newTime) async {
                    setDhikrAlarmTime(newTime, alarmService, languageService, DhikrTime.EVENING, 2);
                  },
                ),

                const SizedBox(
                  height: 40,
                ),
                MenuTitle(text: languageService.getText('aboutUs') , icon: Icons.info),
                StandardElevatedButton(
                  text: languageService.getText('aboutTheApp'),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutAppPage()),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                StandardElevatedButton(
                  text: languageService.getText('externalResources'),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ExternalResourcesPage()),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      )
    );
  }

  void setDhikrAlarmTime(TimeOfDay newTime, AlarmService alarmService, LanguageService languageService, String dhikrTime, int id) async {
    final formattedTime = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
    await alarmService.setAlarm(dhikrTime, formattedTime);
    var dateTime = alarmService.getAlarmValueDateTime(dhikrTime);
    NotificationService().cancelScheduledAlarm(id: id);
    NotificationService().scheduleNotification(
        id: id,
        title: languageService.getText(dhikrTime == DhikrTime.MORNING ? 'morningAlarmNotificationTitle' : 'eveningAlarmNotificationTitle'),
        body: languageService.getText(dhikrTime == DhikrTime.MORNING ? 'morningAlarmNotificationBody' : 'eveningAlarmNotificationBody'),
        scheduledTime: dateTime!,
        payload: dhikrTime);
  }

  void setDhikrAlarmTimeFromCache(AlarmService alarmService, LanguageService languageService, String dhikrTime, int id) async {
    var dateTime = alarmService.getAlarmValueDateTime(dhikrTime);
    NotificationService().cancelScheduledAlarm(id: id);
    NotificationService().scheduleNotification(
        id: id,
        title: languageService.getText(dhikrTime == DhikrTime.MORNING ? 'morningAlarmNotificationTitle' : 'eveningAlarmNotificationTitle'),
        body: languageService.getText(dhikrTime == DhikrTime.MORNING ? 'morningAlarmNotificationBody' : 'eveningAlarmNotificationBody'),
        scheduledTime: dateTime!,
        payload: dhikrTime);
  }
}
