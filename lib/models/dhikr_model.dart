class Dhikr {
  int? id;
  String title;
  String arabicText;
  String? pronounceText;
  String indonesianTranslation;
  String? englishTranslation;
  bool isShowBismillah;
  bool isMorning;
  bool isEvening;
  List<String> references;

  Dhikr({
    required this.id,
    required this.title,
    required this.arabicText,
    this.pronounceText,
    required this.indonesianTranslation,
    this.englishTranslation,
    required this.isShowBismillah,
    required this.isMorning,
    required this.isEvening,
    required this.references,
  });

  factory Dhikr.fromJson(Map<String, dynamic> json) {
    return Dhikr(
      id: json['id'],
      title: json['title'],
      arabicText: json['arabicText'],
      indonesianTranslation: json['indonesianTranslation'],
      englishTranslation: json['englishTranslation'],
      isShowBismillah: json['isShowBismillah'],
      isMorning: json['isMorning'],
      isEvening: json['isEvening'],
      references: List<String>.from(json['references']),
    );
  }
}
