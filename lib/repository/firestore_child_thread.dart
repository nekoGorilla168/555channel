import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_channel/configs/firestore_conf.dart';

class ChildThRepository {
  final db = Firestore.instance;

  final _childThRef = Firestore.instance.collection(FireStoreConf.parentTh);

  // 板子カテゴリに応じたスレ検索
  Future<List<DocumentSnapshot>> select(String id, String category) async {
    try {
      QuerySnapshot qs = await _childThRef
          .document(id)
          .collection(FireStoreConf.CHILDTH)
          .where("category", isEqualTo: category)
          .getDocuments();
      return qs.documents;
    } catch (e) {
      print(e);
      return List<DocumentSnapshot>();
    }
  }

  // 検索(上記と処理は同様)
  Future<DocumentSnapshot> selectOne(String parentId, String childId) async {
    try {
      DocumentSnapshot docs = await _childThRef
          .document(parentId)
          .collection(FireStoreConf.CHILDTH)
          .document(childId)
          .get();
      return docs;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // スレッドを立てる
  void addThread(String parentId, Map map) {
    try {
      _childThRef.document(parentId).collection(FireStoreConf.CHILDTH).add({
        "title": map["title"],
        "category": map["category"],
        "genre": map["genre"],
        "createdAt": map["createdAt"],
        "userId": null,
        "posts": [map["posts"][0]],
      });
    } catch (e) {
      print(e);
    }
  }

  // 投稿書き込み
  void insert(String parentId, String childId, Map map) async {
    var ref = _childThRef
        .document(parentId)
        .collection(FireStoreConf.CHILDTH)
        .document(childId);

    DocumentSnapshot snap = await ref.get();

    if (snap.exists) {
      var index = snap.data["posts"].length.toString();
      ref.setData({
        "posts": FieldValue.arrayUnion([
          {
            "content": map["content"],
            "userId": map["userId"],
            "index": index,
            "target": map["target"],
            "createdAt": map["createdAt"],
          }
        ])
      }, merge: true);
    }
  }

  //返信書き込み
  void reeply(String parentId, String childId, Map map) async {
    try {
      var ref = _childThRef
          .document(parentId)
          .collection(FireStoreConf.CHILDTH)
          .document(childId);

      DocumentSnapshot snap = await ref.get();

      if (snap.exists) {
        var index = snap.data["posts"].length.toString();
        ref.setData({
          "posts": FieldValue.arrayUnion([
            {
              "content": map["content"],
              "userId": map["userId"],
              "index": index,
              "target": map["target"],
              "createdAt": map["createdAt"],
            }
          ])
        }, merge: true);
      }
    } catch (e) {
      print(e);
    }
  }
}
