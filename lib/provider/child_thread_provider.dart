import 'package:flutter_channel/model/child_thread_model.dart';
import 'package:flutter_channel/service/child_thread_service.dart';
import 'package:flutter_channel/view/importer.dart';

class ChildThProvider with ChangeNotifier {
  /* サービスクラス */
  final _svc = ChildThService();

  // 一覧検索
  ChildThProvider.selectList(String id, String category) {
    selectList(id, category);
  }

  // 選択されたスレ検索
  ChildThProvider.selectOne(String parentId, String childId) {
    selectOne(parentId, childId);
  }

  List<ChildThreadModel> _list;
  List<ChildThreadModel> get getList => _list;

  List<ChildThreadModel> _removveList;
  List<ChildThreadModel> get getRemoveList => _removveList;

  List<ChildThreadModel> _filterList;
  List<ChildThreadModel> get getFilterList => _filterList;

  ChildThreadModel _thread;
  ChildThreadModel get getThread => _thread;

  ChildThreadModel _filterTh;
  ChildThreadModel get getFilterTh => _filterTh;

  Future<void> selectList(String id, String category) async {
    _list = await _svc.select(id, category);
    notifyListeners();
  }

  Future<void> selectOne(String parentId, String childId) async {
    _thread = await _svc.selectOne(parentId, childId);
    notifyListeners();
  }

  void addThread(String parentId, String category, List<String> genreList,
      String title, String postContent) {
    _svc.addThread(parentId, category, genreList, title, postContent);
  }

  // 書き込み
  void insert(String parentId, String childId, String text) {
    _svc.insert(parentId, childId, text);
    selectOne(parentId, childId);
  }

  // 返信
  void reply(String parentId, String childId, String text, String target) {
    _svc.reply(parentId, childId, text, target);
    selectOne(parentId, childId);
  }

  void filter(String word) {
    if (word.length >= 2) {
      _filterList =
          _list.where((element) => element.title.contains(word)).toList();
      notifyListeners();
    }
  }

  void filterTh(String word) {
    if (word.length >= 2) {
      var list = _thread.posts
          .where((element) => element["content"].contains(word))
          .toList();
      _filterTh?.posts = list;
      notifyListeners();
    }
  }

  void emptyChk(String word) {
    if (word.isEmpty) {
      _filterList = null;
      notifyListeners();
    }
  }

  void emptyChkTh(String word) {
    if (word.isEmpty) {
      _filterTh.posts = null;
      notifyListeners();
    }
  }

  // レスポンスを改表示するための処理
  bool check(String target) {
    bool isOk = true;
    for (var item in _thread.posts) {
      if (item["index"] == target) {
        isOk = false;
        break;
      }
    }
    return isOk;
  }
}
