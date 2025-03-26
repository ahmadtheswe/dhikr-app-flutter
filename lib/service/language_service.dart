import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String keyLanguage = 'language';
  String? _currentLanguage;
  late Map<String, dynamic> _localizedStrings = {};

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(keyLanguage);

    if (_currentLanguage != null) {
      await _loadLocalizedStrings(_currentLanguage!);
    }
    notifyListeners();
  }

  Future<void> _loadLocalizedStrings(String langCode) async {
    String jsonString = await rootBundle.loadString('assets/lang/$langCode.json');
    _localizedStrings = json.decode(jsonString);
  }

  String getText(String key) {
    var ret = _localizedStrings[key] ?? key;
    return ret;
  }

  Future<void> setLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyLanguage, langCode);
    _currentLanguage = langCode;
    await _loadLocalizedStrings(langCode);
    notifyListeners();
  }

  String? get currentLanguage => _currentLanguage;
}
