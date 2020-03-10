// スレッドモデル
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildThreadModel {
  String id;
  String title;
  String category;
  String index;
  String target;
  List posts;
  List genre;
  DateTime createdAt;

  ChildThreadModel.fromMap(String id, Map map) {
    this.id = id;
    this.title = map[ChildThField.TITLE];
    this.index = map[ChildThField.INDEX];
    this.category = map[ChildThField.CATEGORY];
    this.target = map[ChildThField.TARGET];
    this.posts = map[ChildThField.POSTS];
    this.genre = map[ChildThField.GENRE];
    var timeStmp = map[ChildThField.CREATEDAT];
    if (timeStmp is Timestamp) {
      this.createdAt = DateTime.parse(timeStmp.toDate().toString());
    }
  }
}

class ChildThField {
  static const CATEGORY = "category";
  static const CREATEDAT = "createdAt";
  static const INDEX = "index";
  static const POSTS = "posts";
  static const GENRE = "genre";
  static const TARGET = "target";
  static const RFESPONSE = "response";
  static const TITLE = "title";
}
