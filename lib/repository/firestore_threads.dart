import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_channel/configs/firestore_conf.dart';

class ThreadsRepository {
  final _parentTh = Firestore.instance.collection(FireStoreConf.parentTh);

  final _childTh = Firestore.instance
      .collection(FireStoreConf.parentTh)
      .document()
      .collection(FireStoreConf.childTh);
}
