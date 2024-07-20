class Surah {
  final int number;
  final String englishName;

  Surah({required this.number, required this.englishName});

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      englishName: json['englishName'],
    );
  }
}

class Ayah {
  final String text;

  Ayah({required this.text});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      text: json['text'],
    );
  }
}
