import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:animonarch/data/models/anime_model.dart';

// Exceção personalizada para quando o dispositivo está offline.
class OfflineException implements Exception {
  final String message;
  OfflineException(this.message);
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Connectivity _connectivity = Connectivity();

  Future<void> _checkConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw OfflineException('Sem conexão com a internet. Não é possível salvar os dados.');
    }
  }

  // --- Favoritos ---
  Future<void> addFavorite(Anime anime) async {
    await _checkConnectivity();
    return _db.collection('favorites').doc(anime.id.toString()).set(anime.toJson());
  }

  Future<void> removeFavorite(String animeId) async {
    await _checkConnectivity();
    return _db.collection('favorites').doc(animeId).delete();
  }

  Stream<bool> isFavorite(String animeId) {
    return _db.collection('favorites').doc(animeId).snapshots().map((snapshot) => snapshot.exists);
  }

  // --- Progresso de Episódios ---
  Future<void> setEpisodeWatched(String animeId, int episodeId, bool watched) async {
    await _checkConnectivity();
    final docRef = _db.collection('progress').doc(animeId).collection('episodes').doc(episodeId.toString());
    if (watched) {
      return docRef.set({'watched_at': FieldValue.serverTimestamp()});
    } else {
      return docRef.delete();
    }
  }

  Stream<Set<int>> getWatchedEpisodesStream(String animeId) {
    return _db.collection('progress').doc(animeId).collection('episodes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => int.parse(doc.id)).toSet();
    });
  }
}
