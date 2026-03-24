import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LanguageService extends ChangeNotifier {
  static const String _boxName = 'languageBox';
  static const String keyLanguage = 'language';
  late Box _languageBox;
  String? _currentLanguage;
  late Map<String, dynamic> _localizedStrings = {};

  Future<void> loadLanguage() async {
    _languageBox = await Hive.openBox(_boxName);
    _currentLanguage = _languageBox.get(keyLanguage);

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
    await _languageBox.put(keyLanguage, langCode);
    _currentLanguage = langCode;
    await _loadLocalizedStrings(langCode);
    notifyListeners();
  }

  String? get currentLanguage => _currentLanguage;
}
