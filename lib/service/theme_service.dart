import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeService extends ChangeNotifier {
  ThemeService._internal();

  static final ThemeService _instance = ThemeService._internal();

  factory ThemeService() => _instance;

  static const String _boxName = 'themeBox';
  static const String _themeModeKey = 'themeMode';
  late Box _themeBox;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    _themeBox = await Hive.openBox(_boxName);
    final themeString = _themeBox.get(_themeModeKey);

    if (themeString != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == themeString,
        orElse: () => ThemeMode.system,
      );
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    _setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  void _setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _themeBox.put(_themeModeKey, mode.toString());
    notifyListeners();
  }
}
