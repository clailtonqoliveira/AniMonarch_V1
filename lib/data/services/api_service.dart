import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/models/episode_model.dart';
import 'package:animonarch/data/services/jikan_api_service.dart';

class ApiService {
  final JikanApiService _jikanApiService;

  ApiService({required JikanApiService jikanApiService}) 
      : _jikanApiService = jikanApiService;

  Future<List<Anime>> getTopAnimes() async {
    return _jikanApiService.getTopAnimes();
  }

  Future<List<Anime>> getSeasonalAnimes() async {
    return _jikanApiService.getSeasonalAnimes();
  }

  Future<List<Anime>> getTrendingAnimes() async {
    // Usando top animes como substituto para "trending"
    return _jikanApiService.getTopAnimes();
  }

  Future<Anime> getAnimeDetails(int id) async {
    return _jikanApiService.getAnimeDetails(id);
  }

  Future<List<Episode>> getAnimeEpisodes(int id) async {
    return _jikanApiService.getAnimeEpisodes(id);
  }
}
