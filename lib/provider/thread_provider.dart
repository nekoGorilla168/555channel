import 'package:flutter_channel/model/thread_model.dart';
import 'package:flutter_channel/service/thread_service.dart';
import 'package:flutter_channel/view/importer.dart';

// スレッド操作
class ThreadProvider with ChangeNotifier {
  /* サービスクラス */
  final _svc = ThreadService();

  ThreadProvider() {
    addList();
  }

  List<ThreadModel> _thModelList;
  List<ThreadModel> get getThreadList => _thModelList;

  bool _isShowChildCategory = false;
  bool get childCategory => _isShowChildCategory;

  int _listIndex = 0;
  int get getIndex => _listIndex;

  void addList() async {
    _thModelList = await _svc.initSelect();
    notifyListeners();
  }

  void showCategory() {
    _isShowChildCategory = !_isShowChildCategory;
    notifyListeners();
  }

  void setIndex(int index) {
    _listIndex = index;
  }
}
