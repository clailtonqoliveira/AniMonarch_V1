class Season {
  final int year;
  final String season;

  Season({required this.year, required this.season});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      year: json['year'],
      season: json['season'],
    );
  }
}
