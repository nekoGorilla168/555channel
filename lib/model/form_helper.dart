import 'package:flutter_channel/view/importer.dart';

class FormHelper with ChangeNotifier {
  bool _isShowPassword = false;

  bool get getShow => _isShowPassword;

  void isChangeDisplay() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }
}
