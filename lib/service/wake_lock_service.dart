import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class WakeLockService extends ChangeNotifier {
  WakeLockService._internal();

  static final WakeLockService _instance = WakeLockService._internal();

  factory WakeLockService() => _instance;

  bool get isWakeUpEnabled => _isWakeUpEnabled ?? true;

  static const String _boxName = 'wakeLockBox';
  static const String wakeUpEnabledKey = 'wakeUpEnabled';
  late Box _wakeLockBox;

  bool? _isWakeUpEnabled;

  Future<void> init() async {
    _wakeLockBox = await Hive.openBox(_boxName);
    _isWakeUpEnabled = _wakeLockBox.get(wakeUpEnabledKey) ?? true;
    await _wakeLockBox.put(wakeUpEnabledKey, _isWakeUpEnabled!);

    WakelockPlus.toggle(enable: _isWakeUpEnabled!);

    notifyListeners();
  }

  void toggleWakeUp(bool isWakeUpEnabled) {
    _setWakeUp(isWakeUpEnabled);
  }

  void _setWakeUp(bool mode) async {
    _isWakeUpEnabled = mode;
    await _wakeLockBox.put(wakeUpEnabledKey, mode);
    WakelockPlus.toggle(enable: mode);
    notifyListeners();
  }

}