class Dhikr {
  int? id;
  String title;
  String arabicText;
  String? pronounceText;
  String indonesianTranslation;
  String englishTranslation;
  bool isMorning;
  bool isEvening;
  List<String> references;

  Dhikr({
    required this.id,
    required this.title,
    required this.arabicText,
    this.pronounceText,
    required this.indonesianTranslation,
    required this.englishTranslation,
    required this.isMorning,
    required this.isEvening,
    required this.references,
  });
}