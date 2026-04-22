import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/models/episode_model.dart';
import 'package:animonarch/data/remote/dio_client.dart';
import 'package:dio/dio.dart';

class JikanApiService {
  final Dio _dio = DioClient.instance;

  Future<List<Anime>> getTopAnimes() async {
    try {
      final response = await _dio.get('/top/anime');
      final List<dynamic> data = response.data['data'];
      return data.map((json) => Anime.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get top animes: $e');
    }
  }

  Future<List<Anime>> getSeasonalAnimes() async {
    try {
      final response = await _dio.get('/seasons/now');
      final List<dynamic> data = response.data['data'];
      return data.map((json) => Anime.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get seasonal animes: $e');
    }
  }

  Future<Anime> getAnimeDetails(int id) async {
    try {
      final response = await _dio.get('/anime/$id');
      return Anime.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get anime details: $e');
    }
  }

  Future<List<Episode>> getAnimeEpisodes(int id) async {
    try {
      final response = await _dio.get('/anime/$id/episodes');
      final List<dynamic> data = response.data['data'];
      return data.map((json) => Episode.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get anime episodes: $e');
    }
  }
}
