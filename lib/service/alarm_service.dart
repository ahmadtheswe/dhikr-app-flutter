import 'package:dhikr_app/static/dhikr_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmService extends ChangeNotifier {
  static const String morningAlarmKey = 'morningAlarm';
  static const String eveningAlarmKey = 'eveningAlarm';

  String? _currentMorningAlarm;
  String? _currentEveningAlarm;

  Future<void> loadAlarms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentMorningAlarm = prefs.getString(morningAlarmKey);
    _currentEveningAlarm = prefs.getString(eveningAlarmKey);
    notifyListeners();
  }

  Future<void> setAlarm(String dhikrTime, String formattedTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(dhikrTime == DhikrTime.MORNING ? morningAlarmKey : eveningAlarmKey, formattedTime);

    if (dhikrTime == DhikrTime.MORNING) {
      _currentMorningAlarm = formattedTime;
    } else if (dhikrTime == DhikrTime.EVENING) {
      _currentEveningAlarm = formattedTime;
    }

    notifyListeners();
  }

  TimeOfDay? getAlarmValueTimeOfDay(String dhikrTime) {
    final timeString = dhikrTime == DhikrTime.MORNING ? _currentMorningAlarm : _currentEveningAlarm;

    if (timeString != null) {
      final match = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(timeString.trim());

      if (match != null) {
        int? hours = int.tryParse(match.group(1)!);
        int? minutes = int.tryParse(match.group(2)!);

        if (hours != null && minutes != null) {
          return TimeOfDay(hour: hours, minute: minutes);
        }
      }
    }
    return null;
  }

  String? getAlarmValueString(String dhikrTime) {
    return dhikrTime == DhikrTime.MORNING ? _currentMorningAlarm : _currentEveningAlarm;
  }

  DateTime? getAlarmValueDateTime(String dhikrTime) {
    var dhikrTimeString = dhikrTime == DhikrTime.MORNING ? _currentMorningAlarm : _currentEveningAlarm;
    var parsedTime = '${DateTime.now().toIso8601String().split('T')[0]} ${DateFormat('HH:mm').format(DateFormat.Hm().parse(dhikrTimeString!))}';
    return DateFormat('yyyy-MM-dd HH:mm').parse(parsedTime);
  }
}
