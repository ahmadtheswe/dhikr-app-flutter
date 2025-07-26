import 'package:dhikr_app/pages/dhikr_list_page.dart';
import 'package:dhikr_app/pages/select_dhikr_time_page.dart';
import 'package:dhikr_app/pages/select_language_page.dart';
import 'package:dhikr_app/service/alarm_service.dart';
import 'package:dhikr_app/service/language_service.dart';
import 'package:dhikr_app/service/notification_service.dart';
import 'package:dhikr_app/service/theme_service.dart';
import 'package:dhikr_app/service/update_service.dart';
import 'package:dhikr_app/service/wake_lock_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");  // Add this line to load .env file

  final languageService = LanguageService();
  await languageService.loadLanguage();

  final alarmService = AlarmService();
  await alarmService.loadAlarms();

  await ThemeService().init();

  await WakeLockService().init();

  MobileAds.instance.initialize();

  await NotificationService().init();

  final notificationAppLaunchDetails =
      await NotificationService().flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  String? payload = notificationAppLaunchDetails?.notificationResponse?.payload;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LanguageService>.value(value: languageService),
      ChangeNotifierProvider<AlarmService>.value(value: alarmService),
      ChangeNotifierProvider<ThemeService>.value(value: ThemeService()),
      ChangeNotifierProvider<WakeLockService>.value(value: WakeLockService()),
    ],
    child: MyApp(initialPayload: payload,),
  ));
}

class MyApp extends StatefulWidget {
  final String? initialPayload;

  const MyApp({super.key, this.initialPayload});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    UpdateService().checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final themeService = Provider.of<ThemeService>(context);

    Widget initialPage;
    if (widget.initialPayload != null) {
      initialPage = DhikrListPage(dhikrTime: widget.initialPayload!);
    } else {
      initialPage = languageService.currentLanguage != null ? const SelectDhikrTimePage() : const SelectLanguagePage();
    }

    return MaterialApp(
      title: 'Dzikr App : Morning and Evening',
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
      home: initialPage,
      navigatorKey: navigatorKey,
    );
  }
}
