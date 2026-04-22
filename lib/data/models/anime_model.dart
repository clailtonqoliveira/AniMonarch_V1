import 'package:hive/hive.dart';

part 'anime_model.g.dart';

@HiveType(typeId: 0)
class Anime extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String synopsis;

  @HiveField(4)
  final String type;

  @HiveField(5)
  final int? episodes;

  @HiveField(6)
  final String? score;

  @HiveField(7)
  final String? rated;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    required this.type,
    this.episodes,
    this.score,
    this.rated,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'],
      title: json['title'] ?? 'No Title',
      imageUrl: json['images']?['jpg']?['large_image_url'] ?? '',
      synopsis: json['synopsis'] ?? 'No Synopsis',
      type: json['type'] ?? 'Unknown',
      episodes: json['episodes'],
      score: json['score']?.toString(),
      rated: json['rating'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() => {
        'mal_id': id,
        'title': title,
        'images': {
          'jpg': {'large_image_url': imageUrl}
        },
        'synopsis': synopsis,
        'type': type,
        'episodes': episodes,
        'score': score,
        'rating': rated,
      };
}
