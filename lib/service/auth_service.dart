import 'package:flutter_channel/common/login_user_info.dart';
import 'package:flutter_channel/view/importer.dart';

class AuthService {
  //
  final _auth = FlutterChAuth();

  // 認証済みチェック
  Future<String> chceckAuthenticated() async {
    // チェック
    String uid = await _auth.checkAuthenticated();
    // 認証済みかどうか
    return uid;
  }

  //
}
