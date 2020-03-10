import 'package:flutter_channel/view/importer.dart';

class FlutterChAuth {
  /* リポジトリ */
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 認証されているかどうか
  Future<String> checkAuthenticated() async {
    FirebaseUser user = await _auth.currentUser();
    return user?.uid;
  }

  // 認証(新規ユーザー)
  Future<AuthResult> newSignIn(String email, String passWord) async {
    final AuthResult rs = await _auth.createUserWithEmailAndPassword(
        email: email, password: passWord);

    return rs;
  }

  // 認証(既存ユーザー)
  Future<AuthResult> sigin(String email, String passWord) async {
    final AuthResult rs = await _auth.signInWithEmailAndPassword(
        email: email, password: passWord);
    return rs;
  }

  // サインアウト
  void signOut() {
    _auth.signOut();
  }
  // void sendEmail(String email) {
  //   _auth.sendSignInWithEmailLink(email: email, url: null, handleCodeInApp: null, iOSBundleID: null, androidPackageName: null, androidInstallIfNotAvailable: null, androidMinimumVersion: null)
  // }
}
