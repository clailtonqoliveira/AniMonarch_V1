import 'package:hive/hive.dart';
import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/models/episode_model.dart';

class CacheService {
  static const String _animeBoxName = 'animeCache';
  static const String _episodesBoxName = 'episodesCache';

  // --- Boxes --- //
  Future<Box<Anime>> _getAnimeBox() async {
    return await Hive.openBox<Anime>(_animeBoxName);
  }

  Future<Box<List<dynamic>>> _getEpisodesBox() async {
    // Hive não suporta diretamente List<Episode>, então armazenamos como List<dynamic>
    return await Hive.openBox<List<dynamic>>(_episodesBoxName);
  }

  // --- Operações de Anime --- //
  Future<void> saveAnime(Anime anime) async {
    final box = await _getAnimeBox();
    await box.put(anime.id, anime);
  }

  Future<Anime?> getAnime(int animeId) async {
    final box = await _getAnimeBox();
    return box.get(animeId);
  }

  // --- Operações de Episódios --- //
  Future<void> saveEpisodes(int animeId, List<Episode> episodes) async {
    final box = await _getEpisodesBox();
    // Convertemos a lista de Episodes para uma lista que o Hive entende
    await box.put(animeId, episodes);
  }

  Future<List<Episode>?> getEpisodes(int animeId) async {
    final box = await _getEpisodesBox();
    final episodesDynamic = box.get(animeId);
    if (episodesDynamic != null) {
      // Convertemos de volta para List<Episode>
      return episodesDynamic.cast<Episode>().toList();
    }
    return null;
  }
  
  // --- Limpeza (Opcional, mas bom ter) --- //
  Future<void> clearAllCache() async {
    final animeBox = await _getAnimeBox();
    await animeBox.clear();
    final episodesBox = await _getEpisodesBox();
    await episodesBox.clear();
  }
}
