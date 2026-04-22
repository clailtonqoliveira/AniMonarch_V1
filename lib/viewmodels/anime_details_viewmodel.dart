import 'package:flutter/material.dart';
import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/remote/jikan_api_service.dart';
import 'package:animonarch/viewmodels/home_viewmodel.dart'; // Reutilizando o enum ViewState

class AnimeDetailsViewModel extends ChangeNotifier {
  final JikanApiService _jikanApiService;

  AnimeDetailsViewModel({required JikanApiService jikanApiService}) : _jikanApiService = jikanApiService;

  Anime? _anime;
  Anime? get anime => _anime;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchAnimeDetails(int animeId) async {
    _setState(ViewState.loading);
    try {
      _anime = await _jikanApiService.getAnimeDetails(animeId);
      _setState(ViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }
}
