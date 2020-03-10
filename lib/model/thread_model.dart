import 'package:flutter_channel/view/importer.dart';

// 板モデル
class ThreadModel {
  String parentCategory;
  Map childrenCategory;

  ThreadModel.fromMap(String docId, Map map) {
    this.parentCategory = docId;
    this.childrenCategory = map[ThreadField.CATEGORY];
  }
}

// ドキュメントクラス
class ThreadField {
  static const String CATEGORY = "category"; // 子カテゴリ
}
