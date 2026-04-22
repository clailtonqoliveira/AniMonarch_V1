import 'package:flutter/material.dart';
import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/remote/jikan_api_service.dart';

enum ViewState { idle, loading, success, error }

class HomeViewModel extends ChangeNotifier {
  final JikanApiService _jikanApiService;

  HomeViewModel({required JikanApiService jikanApiService}) : _jikanApiService = jikanApiService {
    fetchHomeData();
  }

  List<Anime> _topAnimes = [];
  List<Anime> get topAnimes => _topAnimes;

  List<Anime> _seasonalAnimes = [];
  List<Anime> get seasonalAnimes => _seasonalAnimes;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchHomeData() async {
    _setState(ViewState.loading);
    try {
      // Executa as duas chamadas em paralelo para otimizar o tempo de carregamento
      final results = await Future.wait([
        _jikanApiService.getTopAnimes(),
        _jikanApiService.getSeasonalAnimes(),
      ]);
      _topAnimes = results[0];
      _seasonalAnimes = results[1];
      _setState(ViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }
}
