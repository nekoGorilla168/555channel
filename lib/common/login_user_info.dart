import 'package:flutter_channel/view/importer.dart';

class UserInfoManager {
  static String _userId;

  String get getUserId => _userId;

  static void setUserId(String uid) {
    _userId = uid;
  }
}
