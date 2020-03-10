import 'package:flutter_channel/view/importer.dart';

class GenreChipState with ChangeNotifier {
  List<String> _genre = [];
  List<String> get getGenreList => _genre;

  bool containGenre(String genreNm) {
    return _genre.contains(genreNm) ? true : false;
  }

  void removeGenre(String genreNm) {
    _genre.remove(genreNm);
    notifyListeners();
  }

  void setGenre(String genreNm) {
    _genre.add(genreNm);
    notifyListeners();
  }
}
