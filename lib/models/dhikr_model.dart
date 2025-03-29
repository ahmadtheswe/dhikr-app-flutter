class Dhikr {
  int? id;
  String title;
  String arabicText;
  String? pronounceText;
  String translation;
  bool isShowBismillah;
  bool isMorning;
  bool isEvening;
  List<String> references;
  int? readTime;

  Dhikr({
    required this.id,
    required this.title,
    required this.arabicText,
    this.pronounceText,
    required this.translation,
    required this.isShowBismillah,
    required this.isMorning,
    required this.isEvening,
    required this.references,
    this.readTime,
  });

  factory Dhikr.fromJson(Map<String, dynamic> json) {
    return Dhikr(
      id: json['id'],
      title: json['title'],
      arabicText: json['arabicText'],
      translation: json['translation'],
      isShowBismillah: json['isShowBismillah'],
      isMorning: json['isMorning'],
      isEvening: json['isEvening'],
      references: List<String>.from(json['references']),
      readTime: json['readTime'],
    );
  }
}
