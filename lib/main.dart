import 'package:dhikr_app/pages/dhikr_list_page.dart';
import 'package:dhikr_app/pages/select_dhikr_time_page.dart';
import 'package:dhikr_app/pages/select_language_page.dart';
import 'package:dhikr_app/service/language_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure async calls are ready

  final languageService = LanguageService();
  await languageService.loadLanguage();

  runApp(ChangeNotifierProvider(
    create: (context) => languageService,
    child: MyApp(
      languageService: languageService,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final LanguageService languageService;

  const MyApp({super.key, required this.languageService});

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
      home: languageService.currentLanguage != null ? const SelectDhikrTimePage() : const SelectLanguagePage(),
    );
  }
}
