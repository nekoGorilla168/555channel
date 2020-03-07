import 'package:flutter_channel/view/importer.dart';

class AuthService {
  //
  final _auth = FlutterChAuth();

  // 認証済みチェック
  bool chceckAuthenticated() {
    // チェック
    Future<String> isAuth = _auth.checkAuthenticated();
    // 認証済みかどうか
    bool isAuthenticated = true;
    //
    if (isAuth == null) {
      isAuthenticated = false;
    } else {
      isAuthenticated = true;
    }
    return isAuthenticated;
  }

  //
}
