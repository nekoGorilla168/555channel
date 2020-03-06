class UserModel {
  String uid;

  UserModel.fromMap(Map map) {
    this.uid = map[];
  }
}

class UserField{
  static String uid = "uid";
}
