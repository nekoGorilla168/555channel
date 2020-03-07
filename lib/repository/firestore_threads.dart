import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_channel/configs/firestore_conf.dart';

class ThreadsRepository {
  final _parentTh = Firestore.instance.collection(FireStoreConf.parentTh);

  Future<List<DocumentSnapshot>> select() async {
    try {
      QuerySnapshot qs = await _parentTh.getDocuments();
      return qs.documents;
    } catch (e) {
      print(e);
      return List<DocumentSnapshot>();
    }
  }
}
