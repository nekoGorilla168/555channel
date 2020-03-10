import 'package:flutter_channel/view/importer.dart';

class ShowSearchBar with ChangeNotifier {
  bool isShow = false;
  bool get getIsShow => isShow;

  void changeState() {
    this.isShow = !isShow;
    notifyListeners();
  }
}
