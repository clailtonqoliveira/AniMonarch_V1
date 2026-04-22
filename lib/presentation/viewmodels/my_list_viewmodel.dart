import 'package:flutter/foundation.dart';
import 'package:animonarch/data/models/anime_model.dart';

class MyListViewModel extends ChangeNotifier {
  final List<Anime> _myList = [];

  List<Anime> get myList => _myList;

  void addToList(Anime anime) {
    if (!_myList.contains(anime)) {
      _myList.add(anime);
      notifyListeners();
    }
  }

  void removeFromList(Anime anime) {
    _myList.remove(anime);
    notifyListeners();
  }

  bool isInList(Anime anime) {
    return _myList.contains(anime);
  }
}
