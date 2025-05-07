class Dhikr {
  int? id;
  Map<String, String> title;
  String arabicText;
  String? pronounceText;
  Map<String, String> translation;
  bool isShowBismillah;
  Map<String, List<String>> references;
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
    required this.isReadTimeForWholeDay,
  });

  factory Dhikr.fromJson(Map<String, dynamic> json) {
    return Dhikr(
      id: json['id'],
      title: Map<String, String>.from(json['title']),
      arabicText: json['arabicText'],
      pronounceText: json['pronounceText'],
      translation: Map<String, String>.from(json['translation']),
      isShowBismillah: json['isShowBismillah'],
      references: Map<String, List<String>>.from(json['references']
          .map((key, value) => MapEntry(key, List<String>.from(value)))),
      readTime: json['readTime'] != null ? List<int>.from(json['readTime']) : null,
      isReadTimeForWholeDay: json['isReadTimeForWholeDay'],
    );
  }
}
