class Dhikr {
  int? id;
  String title;
  String arabicText;
  String? pronounceText;
  String translation;
  bool isShowBismillah;
  List<String> references;
  int? readTime;

  Dhikr({
    required this.id,
    required this.title,
    required this.arabicText,
    this.pronounceText,
    required this.translation,
    required this.isShowBismillah,
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
      references: List<String>.from(json['references']),
      readTime: json['readTime'],
    );
  }
}
