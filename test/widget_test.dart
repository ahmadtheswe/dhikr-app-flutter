import 'package:dhikr_app/main.dart';
import 'package:dhikr_app/pages/select_dhikr_time_page.dart';
import 'package:dhikr_app/pages/select_language_page.dart';
import 'package:dhikr_app/service/alarm_service.dart';
import 'package:dhikr_app/service/language_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('MyApp shows SelectDhikrTimePage when language is set', (WidgetTester tester) async {
    // Arrange
    final languageService = LanguageService();
    await languageService.setLanguage('en');

    final alarmService = AlarmService();
    await alarmService.loadAlarms();

    // Act
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageService>.value(value: languageService),
        ChangeNotifierProvider<AlarmService>.value(value: alarmService),
      ],
      child: const MyApp(),
    ));

    // Assert
    expect(find.byType(SelectDhikrTimePage), findsOneWidget);
    expect(find.byType(SelectLanguagePage), findsNothing);
  });

  testWidgets('MyApp shows SelectLanguagePage when language is not set', (WidgetTester tester) async {
    // Arrange
    final languageService = LanguageService();

    final alarmService = AlarmService();
    await alarmService.loadAlarms();

    // Act
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageService>.value(value: languageService),
        ChangeNotifierProvider<AlarmService>.value(value: alarmService),
      ],
      child: const MyApp(),
    ));

    // Assert
    expect(find.byType(SelectDhikrTimePage), findsNothing);
    expect(find.byType(SelectLanguagePage), findsOneWidget);
  });
}
