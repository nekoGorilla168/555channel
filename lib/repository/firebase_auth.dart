import 'package:flutter_channel/view/importer.dart';

class FlutterChAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 認証されているかどうか
  Future<String> checkAuthenticated() async {
    FirebaseUser user = await _auth.currentUser();
    print(user.providerData);

    print(user);

    return user?.uid;
  }

  // 認証(新規ユーザー)
  Future<AuthResult> newSignIn(String email, String passWord) async {
    final AuthResult rs = await _auth.createUserWithEmailAndPassword(
        email: email, password: passWord);
    _checkAuthResult(rs);
    return rs;
  }

  // 認証(既存ユーザー)
  Future<AuthResult> sigin(String email, String passWord) async {
    final AuthResult rs = await _auth.signInWithEmailAndPassword(
        email: email, password: passWord);
    return rs;
  }

  //

  void _checkAuthResult(AuthResult rs) {
    print(rs.user);
  }
}
