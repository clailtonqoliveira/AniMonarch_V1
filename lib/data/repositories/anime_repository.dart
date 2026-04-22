import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/models/episode_model.dart';
import 'package:animonarch/data/services/api_service.dart';
import 'package:animonarch/data/services/cache_service.dart';
import 'dart:developer' as developer;

class AnimeRepository {
  final ApiService _apiService;
  final CacheService _cacheService;

  AnimeRepository(this._apiService, this._cacheService);

  // Métodos que não precisam de cache complexo por enquanto
  Future<List<Anime>> getTrendingAnimes() => _apiService.getTrendingAnimes();
  Future<List<Anime>> getSeasonalAnimes() => _apiService.getSeasonalAnimes();
  Future<List<Anime>> getTopAnimes() => _apiService.getTopAnimes();

  // --- Lógica de Cache Híbrido ---

  Future<Anime?> getAnimeDetails(int id) async {
    // 1. Tenta buscar do Cache primeiro
    final cachedAnime = await _cacheService.getAnime(id);
    if (cachedAnime != null) {
      developer.log('Anime ID: $id encontrado no cache.', name: 'CacheHit');
      return cachedAnime;
    }

    // 2. Se não estiver no cache, busca na API
    developer.log('Anime ID: $id não encontrado no cache. Buscando na API...', name: 'CacheMiss');
    final apiAnime = await _apiService.getAnimeDetails(id);

    // 3. Salva o resultado da API no cache para futuras requisições
    await _cacheService.saveAnime(apiAnime);
    developer.log('Anime ID: $id salvo no cache.', name: 'CacheWrite');
  
    return apiAnime;
  }

  Future<List<Episode>> getAnimeEpisodes(int id) async {
    // 1. Tenta buscar do Cache primeiro
    final cachedEpisodes = await _cacheService.getEpisodes(id);
    if (cachedEpisodes != null) {
      developer.log('Episódios para o Anime ID: $id encontrados no cache.', name: 'CacheHit');
      return cachedEpisodes;
    }

    // 2. Se não estiver no cache, busca na API
    developer.log('Episódios para o Anime ID: $id não encontrados no cache. Buscando na API...', name: 'CacheMiss');
    final apiEpisodes = await _apiService.getAnimeEpisodes(id);

    // 3. Salva o resultado da API no cache
    await _cacheService.saveEpisodes(id, apiEpisodes);
    developer.log('Episódios para o Anime ID: $id salvos no cache.', name: 'CacheWrite');

    return apiEpisodes;
  }
}
