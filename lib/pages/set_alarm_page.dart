import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/alarm_service.dart';
import '../service/language_service.dart';
import '../service/notification_service.dart';
import '../shared/button/leading_back_button.dart';
import '../shared/title/page_title.dart';
import '../static/dhikr_time.dart';
import '../widget/alarm_widget.dart';

class SetAlarmPage extends StatefulWidget {
  const SetAlarmPage({super.key});

  @override
  State<SetAlarmPage> createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  @override
  Widget build(BuildContext context) {
    final alarmService = Provider.of<AlarmService>(context);
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const LeadingBackButton(),
        title: PageTitle(
          text: languageService.getText('setYourAlarmsPageTitle'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
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
            ],
          ),
        ],
      ),
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
