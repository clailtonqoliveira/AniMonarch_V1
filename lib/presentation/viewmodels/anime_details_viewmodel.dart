
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/models/episode_model.dart';
import 'package:animonarch/data/repositories/anime_repository.dart';
import 'package:animonarch/data/services/firestore_service.dart';
import 'package:animonarch/core/utils/view_state.dart';

class AnimeDetailsViewModel extends ChangeNotifier {
  final AnimeRepository _animeRepository;
  final FirestoreService _firestoreService;

  AnimeDetailsViewModel(this._animeRepository, this._firestoreService);

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  Anime? _anime;
  Anime? get anime => _anime;

  List<Episode> _episodes = [];
  List<Episode> get episodes => _episodes;

  String? _errorMessage; // Para erros persistentes na tela
  String? get errorMessage => _errorMessage;
  
  String? _userMessage; // Para mensagens temporárias (ex: SnackBars)
  String? get userMessage => _userMessage;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  StreamSubscription? _favoriteSubscription;

  Future<void> fetchAnimeDetails(int animeId) async {
    _setState(ViewState.loading);
    _listenToFavoriteStatus(animeId.toString());
    try {
      final results = await Future.wait([
        _animeRepository.getAnimeDetails(animeId),
        _animeRepository.getAnimeEpisodes(animeId),
      ]);
      
      _anime = results[0] as Anime?;
      _episodes = results[1] as List<Episode>;

      _setState(ViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  void _listenToFavoriteStatus(String animeId) {
    _favoriteSubscription?.cancel();
    _favoriteSubscription = _firestoreService.isFavorite(animeId).listen((status) {
      _isFavorite = status;
      notifyListeners();
    });
  }

  Future<void> toggleFavorite() async {
    if (_anime == null) return;
    
    clearUserMessage(); // Limpa mensagens antigas

    try {
      if (_isFavorite) {
        await _firestoreService.removeFavorite(_anime!.id.toString());
      } else {
        await _firestoreService.addFavorite(_anime!);
      }
    } on OfflineException catch (e) {
      _userMessage = e.message;
      notifyListeners(); // Notifica a UI para mostrar a mensagem
    } catch (e) {
      _userMessage = "Ocorreu um erro inesperado.";
      notifyListeners();
    }
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  void clearUserMessage() {
    _userMessage = null;
  }
  
  @override
  void dispose() {
    _favoriteSubscription?.cancel();
    super.dispose();
  }

  bool get isLoading => _state == ViewState.loading;
  bool get hasData => _state == ViewState.success;
  bool get hasError => _state == ViewState.error;
}
