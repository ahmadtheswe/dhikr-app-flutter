import 'package:dhikr_app/pages/dhikr_list_page.dart';
import 'package:dhikr_app/pages/select_language.dart';
import 'package:flutter/material.dart';

import 'utils/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure async calls are ready

  bool isDarkMode = await UserPreferences.getDarkMode();
  String? language = await UserPreferences.getLanguage();

  runApp(MyApp(isDarkMode: isDarkMode, language: language));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  final String? language;

  const MyApp({super.key, required this.isDarkMode, this.language});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dzikr App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      // home: const DhikrListPage(title: 'Your Dhikr App'),
      home: language != null ? const DhikrListPage(title: 'Your Dhikr App') : const SelectLanguage(),
    );
  }
}
