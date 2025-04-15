import 'package:dhikr_app/pages/select_dhikr_time_page.dart';
import 'package:dhikr_app/pages/select_language_page.dart';
import 'package:dhikr_app/service/alarm_service.dart';
import 'package:dhikr_app/service/language_service.dart';
import 'package:dhikr_app/service/notification_service.dart';
import 'package:dhikr_app/service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final languageService = LanguageService();
  await languageService.loadLanguage();

  final alarmService = AlarmService();
  await alarmService.loadAlarms();

  final themeService = ThemeService();

  MobileAds.instance.initialize();

  await NotificationService().init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LanguageService>.value(value: languageService),
      ChangeNotifierProvider<AlarmService>.value(value: alarmService),
      ChangeNotifierProvider<ThemeService>.value(value: themeService),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final themeService = Provider.of<ThemeService>(context);

    return MaterialApp(
      title: 'Dzikr App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeService.themeMode,
      debugShowCheckedModeBanner: false,
      home: languageService.currentLanguage != null ? const SelectDhikrTimePage() : const SelectLanguagePage(),
      navigatorKey: navigatorKey,
    );
  }
}
