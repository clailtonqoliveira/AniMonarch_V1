import 'package:hive/hive.dart';

part 'episode_model.g.dart';

@HiveType(typeId: 1)
class Episode extends HiveObject{
  @HiveField(0)
  final int malId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? aired;

  @HiveField(3)
  final double? score;
  
  // Este campo não vem da API de episódios, mas é útil ter.
  // O número do episódio é o próprio malId na API Jikanv4
  @HiveField(4)
  int get episodeNumber => malId;


  Episode({
    required this.malId,
    required this.title,
    this.aired,
    this.score,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      malId: json['mal_id'],
      title: json['title'] ?? 'No Title',
      aired: json['aired'],
      score: json['score']?.toDouble(),
    );
  }
}
