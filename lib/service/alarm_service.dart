import 'package:dhikr_app/static/dhikr_time.dart';
import 'package:flutter/material.dart';
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

  TimeOfDay? getAlarmValue(String dhikrTime) {
    final timeString = dhikrTime == DhikrTime.MORNING ? _currentMorningAlarm : _currentEveningAlarm;

    if (timeString != null) {
      final match = RegExp(r'(\d{1,2}):(\d{2})\s*([APap][Mm])?').firstMatch(timeString.trim());

      if (match != null) {
        int? hours = int.tryParse(match.group(1)!);
        int? minutes = int.tryParse(match.group(2)!);
        String? period = match.group(3)?.toUpperCase();

        if (hours != null && minutes != null) {
          if (period != null) {
            if (period == 'PM' && hours < 12) {
              hours += 12;
            } else if (period == 'AM' && hours == 12) {
              hours = 0;
            }
          }
          return TimeOfDay(hour: hours, minute: minutes);
        }
      }
    }
    return null;
  }
}
