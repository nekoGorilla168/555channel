import 'package:flutter_channel/provider/thread_provider.dart';
import 'package:flutter_channel/view/importer.dart';

class FlutterChHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("555ちゃんねる"),
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
    final _thPrv = Provider.of<ThreadProvider>(context);
    // スレカテゴリ一覧表示検索
    _thPrv.addList();

    return _thPrv.getThreadList != null
        ? ListView.builder(
            itemCount: _thPrv.getThreadList.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(_thPrv.getThreadList[index].parentCategory),
                    onTap: () {
                      _thPrv.setIndex(index);
                      _thPrv.showCategory();
                    },
                  ),
                  Divider(),
                  Column(
                    children: _thPrv.childCategory && _thPrv.getIndex == index
                        ? showChild(
                            _thPrv.getThreadList[index].childrenCategory,
                            context)
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
  List<Widget> showChild(Map map, BuildContext context) {
    List<Widget> list = List<Widget>();

    map.forEach((key, value) {
      var item = ListTile(
        title: Text(value),
        contentPadding: EdgeInsets.only(left: 40.0),
        onTap: () {},
      );
      list.add(item);
    });
    return list;
  }
}
