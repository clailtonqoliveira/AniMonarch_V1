import 'package:flutter/material.dart';
import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/repositories/anime_repository.dart';
import 'package:animonarch/core/utils/view_state.dart';

class HomeViewModel extends ChangeNotifier {
  final AnimeRepository _animeRepository;

  HomeViewModel(this._animeRepository);

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<Anime> _trendingAnimes = [];
  List<Anime> get trendingAnimes => _trendingAnimes;

  List<Anime> _seasonalAnimes = [];
  List<Anime> get seasonalAnimes => _seasonalAnimes;

  List<Anime> _topAnimes = [];
  List<Anime> get topAnimes => _topAnimes;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Método único para buscar todos os dados da home
  Future<void> fetchData() async {
    // Evita múltiplas chamadas se já estiver carregando
    if (_state == ViewState.loading) return;

    _setState(ViewState.loading);
    try {
      // Realiza as chamadas em paralelo
      final results = await Future.wait([
        _animeRepository.getTrendingAnimes(),
        _animeRepository.getSeasonalAnimes(),
        _animeRepository.getTopAnimes(),
      ]);

      _trendingAnimes = results[0];
      _seasonalAnimes = results[1];
      _topAnimes = results[2];

      _setState(ViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  bool get isLoading => _state == ViewState.loading;
  bool get hasData => _state == ViewState.success;
  bool get hasError => _state == ViewState.error;
}
