import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  ThemeService._internal();

  static final ThemeService _instance = ThemeService._internal();

  factory ThemeService() => _instance;

  static const String _themeModeKey = 'themeMode';
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeModeKey);

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
    final prefs = await SharedPreferences.getInstance();
    _themeMode = mode;
    await prefs.setString(_themeModeKey, mode.toString());
    notifyListeners();
  }
}
