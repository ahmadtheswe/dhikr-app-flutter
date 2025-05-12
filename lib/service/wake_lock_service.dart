import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class WakeLockService extends ChangeNotifier {
  WakeLockService._internal();

  static final WakeLockService _instance = WakeLockService._internal();

  factory WakeLockService() => _instance;

  bool get isWakeUpEnabled => _isWakeUpEnabled ?? true;

  static const String wakeUpEnabledKey = 'wakeUpEnabled';

  bool? _isWakeUpEnabled;

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isWakeUpEnabled = prefs.getBool(wakeUpEnabledKey) ?? true;
    await prefs.setBool(wakeUpEnabledKey, _isWakeUpEnabled!);

    WakelockPlus.toggle(enable: _isWakeUpEnabled!);

    notifyListeners();
  }

  void toggleWakeUp(bool isWakeUpEnabled) {
    _setWakeUp(isWakeUpEnabled);
  }

  void _setWakeUp(bool mode) async {
    final prefs = await SharedPreferences.getInstance();
    _isWakeUpEnabled = mode;
    await prefs.setBool(wakeUpEnabledKey, mode);
    WakelockPlus.toggle(enable: mode);
    notifyListeners();
  }

}