import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_channel/common/login_user_info.dart';
import 'package:flutter_channel/model/child_thread_model.dart';
import 'package:flutter_channel/model/post_model.dart';
import 'package:flutter_channel/repository/firestore_child_thread.dart';

class ChildThService {
  final _repos = ChildThRepository();

  var user = UserInfoManager();

  Future<List<ChildThreadModel>> select(String id, String category) async {
    List<ChildThreadModel> list = List<ChildThreadModel>();
    try {
      List<DocumentSnapshot> docs = await _repos.select(id, category);

      list = docs
          .map((e) => ChildThreadModel.fromMap(e.documentID, e.data))
          .toList();

      return list;
    } catch (e) {
      print(e);
      return List<ChildThreadModel>();
    }
  }

  // スレ立て
  void addThread(String parentId, String category, List<String> genreList,
      String title, String postContent) {
    try {
      Map map = {
        "title": title,
        "category": category,
        "createdAt": DateTime.now(),
        "genre": genreList,
        "posts": [
          PostModel().toMapByAddThread(PostModel(content: postContent)),
        ],
      };
      _repos.addThread(parentId, map);
    } catch (e) {
      print(e);
    }
  }

  // スレの内容取得
  Future<ChildThreadModel> selectOne(String parentId, String childId) async {
    try {
      DocumentSnapshot docs = await _repos.selectOne(parentId, childId);
      return ChildThreadModel.fromMap(docs.documentID, docs.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 書き込み
  void insert(String parentId, String childId, String text) {
    try {
      Map map =
          PostModel().toMap(PostModel(content: text, uid: user.getUserId));
      _repos.insert(parentId, childId, map);
    } catch (e) {
      print(e);
    }
  }

  // 返信
  void reply(String parentId, String childId, String text, String target) {
    try {
      Map map = PostModel().toMapAsReply(
          PostModel(content: text, uid: user.getUserId, target: target));
      _repos.reeply(parentId, childId, map);
    } catch (e) {
      print(e);
    }
  }
}
