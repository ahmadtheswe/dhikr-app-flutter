import 'package:dhikr_app/pages/select_dhikr_time_page.dart';
import 'package:dhikr_app/pages/select_language_page.dart';
import 'package:dhikr_app/service/alarm_service.dart';
import 'package:dhikr_app/service/language_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure async calls are ready

  final languageService = LanguageService();
  await languageService.loadLanguage();

  final alarmService = AlarmService();
  await alarmService.loadAlarms();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LanguageService>.value(value: languageService),
      ChangeNotifierProvider<AlarmService>.value(value: alarmService),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return MaterialApp(
      title: 'Dzikr App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: languageService.currentLanguage != null ? const SelectDhikrTimePage() : const SelectLanguagePage(),
    );
  }
}
