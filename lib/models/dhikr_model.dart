class Dhikr {
  int? id;
  String title;
  String arabicText;
  String? pronounceText;
  String translation;
  bool isShowBismillah;
  List<String> references;
  List<int>? readTime;
  bool isReadTimeForWholeDay;

  Dhikr({
    required this.id,
    required this.title,
    required this.arabicText,
    this.pronounceText,
    required this.translation,
    required this.isShowBismillah,
    required this.references,
    this.readTime,
    required this.isReadTimeForWholeDay
  });

  factory Dhikr.fromJson(Map<String, dynamic> json) {
    return Dhikr(
      id: json['id'],
      title: json['title'],
      arabicText: json['arabicText'],
      translation: json['translation'],
      isShowBismillah: json['isShowBismillah'],
      references: List<String>.from(json['references']),
      readTime: json['readTime'] != null ? List<int>.from(json['readTime']) : null,
      isReadTimeForWholeDay: json['isReadTimeForWholeDay'],
    );
  }
}
