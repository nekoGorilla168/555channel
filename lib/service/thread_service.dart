import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_channel/model/thread_model.dart';
import 'package:flutter_channel/repository/firestore_threads.dart';

class ThreadService {
  /* リポジトリ */
  final _repos = ThreadsRepository();

  List<ThreadModel> thModelList;

// 初期化検索
  Future<List<ThreadModel>> initSelect() async {
    List<DocumentSnapshot> docs = await _repos.select();

    thModelList =
        docs.map((e) => ThreadModel.fromMap(e.documentID, e.data)).toList();
    return thModelList;
  }
}
