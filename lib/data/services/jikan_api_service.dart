import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/models/episode_model.dart';

class JikanApiService {
  final String _baseUrl = 'https://api.jikan.moe/v4';

  Future<List<Anime>> _fetchAnimeList(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((item) => Anime.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar lista de animes do endpoint: $endpoint');
    }
  }

  Future<List<Anime>> getTopAnimes() async {
    return _fetchAnimeList('top/anime');
  }

  Future<List<Anime>> getSeasonalAnimes() async {
    return _fetchAnimeList('seasons/now');
  }

  Future<Anime> getAnimeDetails(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/anime/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return Anime.fromJson(data);
    } else {
      throw Exception('Falha ao carregar detalhes do anime');
    }
  }

  Future<List<Episode>> getAnimeEpisodes(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/anime/$id/episodes'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((item) => Episode.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar episódios do anime');
    }
  }
}
