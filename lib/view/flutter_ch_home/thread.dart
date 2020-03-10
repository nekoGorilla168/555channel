import 'package:flutter_channel/configs/font.dart';
import 'package:flutter_channel/provider/child_thread_provider.dart';
import 'package:flutter_channel/provider/show_search_bar.dart';
import 'package:flutter_channel/view/importer.dart';
import 'package:intl/intl.dart';

class Thread extends StatelessWidget {
  //
  final postController = TextEditingController();
  // 日付

  // スレの内容
  final String parentId;
  final String title;
  final String childId;
  // コンストラクタ
  Thread(this.parentId, this.childId, this.title);

  @override
  Widget build(BuildContext context) {
    // TODO
    print("Build Thread");

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowSearchBar>(
          create: (_) => ShowSearchBar(),
        ),
        ChangeNotifierProvider<ChildThProvider>(
          create: (_) => ChildThProvider.selectOne(parentId, childId),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppSearchOrTextBar(title, parentId, childId),
          body: Consumer<ChildThProvider>(
            builder: (context, value, child) {
              return value?.getFilterTh?.posts != null
                  ? RefreshIndicator(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: value.getFilterTh.posts?.length,
                        itemBuilder: (context, index) {
                          // 書き込みに対する内容
                          var content = value.getFilterTh.posts[index];
                          var th = value.getFilterTh;
                          List responses = th.posts
                              .where((element) =>
                                  element["target"] == content["index"])
                              .toList();
                          bool isShow = value.check(content["target"]);
                          if (isShow) {
                            return Column(
                              children: <Widget>[
                                InkWell(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("投稿"),
                                          content: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Container(
                                              height: 100.0,
                                              child: TextFormField(
                                                controller: postController,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("キャンセル")),
                                            FlatButton(
                                              onPressed: () {
                                                value.reply(
                                                    parentId,
                                                    childId,
                                                    postController.text,
                                                    content["index"]);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                DateFormat.yMd()
                                                    .add_Hm()
                                                    .format(
                                                        content["createdAt"]),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: Text((content["index"])
                                                  .toString()),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 6.0),
                                              child: Text(
                                                "どこかの誰かさん",
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 50.0),
                                              child: Text(
                                                DateFormat.yMd()
                                                    .add_Hm()
                                                    .format(DateTime.parse(
                                                        content["createdAt"]
                                                            .toDate()
                                                            .toString())),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            content["content"],
                                            softWrap: true,
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1.0,
                                ),
                                responses.length == 0
                                    ? Container()
                                    : createResponse(
                                        context, responses, responses[0], 15.0)
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      onRefresh: () {
                        //value.selectList(thread.id, thread.category);
                      },
                    )
                  : value?.getThread?.posts != null
                      ? RefreshIndicator(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: value?.getThread?.posts?.length,
                            itemBuilder: (context, index) {
                              // 書き込みに対する内容
                              var content = value.getThread.posts[index];
                              var th = value.getThread;
                              List responses = th.posts
                                  .where((element) =>
                                      element["target"] == content["index"])
                                  .toList();
                              bool isShow = value.check(content["target"]);
                              if (isShow) {
                                return Column(
                                  children: <Widget>[
                                    InkWell(
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("投稿"),
                                              content: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Container(
                                                  height: 100.0,
                                                  child: TextFormField(
                                                    controller: postController,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: null,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("キャンセル")),
                                                FlatButton(
                                                  onPressed: () {
                                                    value.reply(
                                                        parentId,
                                                        childId,
                                                        postController.text,
                                                        content["index"]);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("書き込む"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text((content["index"])
                                                      .toString()),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6.0),
                                                  child: Text(
                                                    "どこかの誰かさん",
                                                    style: TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 50.0),
                                                  child: Text(
                                                    DateFormat.yMd()
                                                        .add_Hm()
                                                        .format(DateTime.parse(
                                                            content["createdAt"]
                                                                .toDate()
                                                                .toString())),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                content["content"],
                                                softWrap: true,
                                                style:
                                                    TextStyle(fontSize: 15.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                    ),
                                    responses.length == 0
                                        ? Container()
                                        : createResponse(context, responses,
                                            responses[0], 15.0)
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          onRefresh: () async {
                            await value.selectOne(parentId, childId);
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
            },
          ),
        ),
      ),
    );
  }

  // レスポンス(再帰的に行う必要あり)
  Widget createResponse(
      BuildContext context, List list, Map content, double pad) {
    final _thPrv = Provider.of<ChildThProvider>(context);
    var th = _thPrv.getThread;
    var responses = th.posts
        .where((element) => element["target"] == content["index"])
        .toList();

    return Column(
      children: <Widget>[
        InkWell(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("投稿"),
                  content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 100.0,
                      child: TextFormField(
                        controller: postController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("キャンセル")),
                    FlatButton(
                      onPressed: () {
                        _thPrv.reply(parentId, childId, postController.text,
                            content["index"]);
                        Navigator.of(context).pop();
                      },
                      child: Text("書き込む"),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            padding: EdgeInsets.only(top: 5.0, left: pad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.reply,
                  size: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        (content["index"]).toString(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Text(
                        "どこかの誰かさん",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Text(
                        DateFormat.yMd().add_Hm().format(DateTime.parse(
                            content["createdAt"].toDate().toString())),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    content["content"],
                    softWrap: true,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1.0,
        ),
        responses.length == 0
            ? Container()
            : createResponse(context, responses, responses[0], (pad + 10.0)),
      ],
    );
  }
}

class AppSearchOrTextBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String parentId;
  final String childId;
  AppSearchOrTextBar(this.title, this.parentId, this.childId);
  final serachController = TextEditingController();
  @override
  Size get preferredSize => Size.fromHeight(55.0);

  @override
  Widget build(BuildContext context) {
    // TODO デバッグ
    print("Build!");
    final _thPrv = Provider.of<ChildThProvider>(context, listen: false);
    /* 検索バー状態管理 */
    final _show = Provider.of<ShowSearchBar>(context);
    return AppBar(
      title: _show.getIsShow
          ? _searchField(Provider.of<ChildThProvider>(context, listen: false))
          : Text(
              title,
              style: AppFont.THREADTITLE,
            ),
      actions: <Widget>[
        SerachBtn(),
        PopupMenuButton(
          itemBuilder: (context) => <PopupMenuItem<String>>[
            PopupMenuItem(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("投稿"),
                        content: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: 100.0,
                            child: TextFormField(
                              controller: serachController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("キャンセル")),
                          FlatButton(
                            onPressed: () {
                              _thPrv.insert(
                                  parentId, childId, serachController.text);
                              Navigator.of(context).pop();
                            },
                            child: Text("書き込む"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('書き込む'),
              ),
            )
          ],
        ),
      ],
    );
  }

  // 検索フォームを返却する
  Widget _searchField(ChildThProvider th) {
    return TextFormField(
      controller: serachController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "検索",
        border: InputBorder.none,
      ),
      onChanged: (word) {
        th.emptyChkTh(word);
      },
      onEditingComplete: () {
        th.filterTh(serachController.text);
      },
    );
  }
}

/* 検索ボタン */
class SerachBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* 検索バー状態管理 */
    final _show = Provider.of<ShowSearchBar>(context, listen: false);
    return IconButton(
      icon: Icon(
        Icons.search,
        color: Colors.white,
      ),
      onPressed: () => _show.changeState(),
    );
  }
}
