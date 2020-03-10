import 'package:flutter_channel/configs/thread_constants.dart';
import 'package:flutter_channel/provider/thread_provider.dart';
import 'package:flutter_channel/view/flutter_ch_home/thread_list.dart';
import 'package:flutter_channel/view/importer.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FlutterChHome extends StatelessWidget {
  final _auth = FlutterChAuth();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("555ちゃんねる"),
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (context) => <PopupMenuItem>[
                    PopupMenuItem(
                        child: FlatButton(
                            onPressed: () {
                              _auth.signOut();
                            },
                            child: Text("サインアウト"))),
                  ])
        ],
      ),
      body: ChangeNotifierProvider<ThreadProvider>(
        create: (_) => ThreadProvider(),
        child: ThreadList(),
      ),
    ));
  }
}

class ThreadList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO ビルドチェック
    print("Build ThreadList");

    final _thPrv = Provider.of<ThreadProvider>(context);

    return _thPrv.getThreadList != null
        ? ListView.builder(
            itemCount: _thPrv.getThreadList.length,
            itemBuilder: (context, index) {
              // 親カテゴリ
              var parentCaregory = _thPrv.getThreadList[index].parentCategory;
              // 子カテゴリ(複数)
              var childrenCategory =
                  _thPrv.getThreadList[index].childrenCategory;
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      ThreadCons.parentCategory(parentCaregory),
                    ),
                    onTap: () {
                      _thPrv.setIndex(index);
                      _thPrv.showCategory();
                    },
                  ),
                  Divider(),
                  Column(
                    children: _thPrv.childCategory && _thPrv.getIndex == index
                        ? showChild(parentCaregory, childrenCategory, context)
                        : <Widget>[],
                  ),
                ],
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  // 子カテゴリ表示
  List<Widget> showChild(String id, Map map, BuildContext context) {
    List<Widget> list = List<Widget>();

    map.forEach((key, value) {
      var item = ListTile(
        title: Text(value),
        contentPadding: EdgeInsets.only(left: 40.0),
        onTap: () {
          // カテゴリ名称
          var category = value;
          // スレッド一覧ページへ遷移
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FlutterChThList(id, category),
            ),
          );
        },
      );
      list.add(item);
    });
    return list;
  }
}
