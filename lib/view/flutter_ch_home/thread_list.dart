import 'package:flutter_channel/provider/child_thread_provider.dart';
import 'package:flutter_channel/provider/genre_chip_state.dart';
import 'package:flutter_channel/provider/show_search_bar.dart';
import 'package:flutter_channel/view/flutter_ch_home/thread.dart';
import 'package:flutter_channel/view/flutter_ch_input_dialog/custom_dialog.dart';
import 'package:flutter_channel/view/importer.dart';

class FlutterChThList extends StatelessWidget {
  final String id; // カテゴリのID
  final String category; // 現在表示しているスレのカテゴリ
  // スレ一覧検索
  FlutterChThList(this.id, this.category);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChildThProvider>(
          create: (_) => ChildThProvider.selectList(id, category),
        ),
        ChangeNotifierProvider<ShowSearchBar>(
          create: (_) => ShowSearchBar(),
        ),
        ChangeNotifierProvider<GenreChipState>(
          create: (_) => GenreChipState(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppSearchOrTextBar(id, category),
          body: Consumer<ChildThProvider>(
            builder: (context, value, child) {
              return value.getFilterList != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: value.getFilterList?.length,
                      itemBuilder: (context, index) {
                        // スレッドの情報
                        var filterThread = value.getFilterList[index];
                        return ListTile(
                          title: Text(filterThread.title),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Thread(
                                    id, filterThread.id, filterThread.title),
                              ),
                            );
                          },
                          subtitle: createGenreList(filterThread.genre),
                        );
                      },
                    )
                  : value.getList != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: value.getList.length,
                          itemBuilder: (context, index) {
                            // スレッドの情報
                            var thread = value.getList[index];
                            return ListTile(
                              title: Text(thread.title),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Thread(id, thread.id, thread.title),
                                  ),
                                );
                              },
                              subtitle: createGenreList(thread.genre),
                            );
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

  Widget createGenreList(List genre) {
    String genreNm = "";
    if (genre != null) {
      for (var i = 0; i < genre.length; i++) {
        if (i == (genre.length - 1)) {
          genreNm += genre[i];
        } else {
          genreNm += genre[i] + " /";
        }
      }
    }
    return Text(genreNm);
  }
}

class AppSearchOrTextBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String id;
  final String category;

  AppSearchOrTextBar(this.id, this.category);
  final serachController = TextEditingController();
  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    // TODO デバッグ
    print("Build!");

    /* 検索バー状態管理 */
    final _show = Provider.of<ShowSearchBar>(context);
    return AppBar(
      title: _show.getIsShow
          ? _searchField(Provider.of<ChildThProvider>(context, listen: false))
          : Text(category),
      actions: <Widget>[
        SerachBtn(),
        UpdateBtn(id, category),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            CustomDialog(context, id, category).ShowCustomDialog();
          },
        )
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
      onEditingComplete: () {
        th.filter(serachController.text);
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

/* 更新ボタン */
class UpdateBtn extends StatelessWidget {
  final String id;
  final String category;

  UpdateBtn(this.id, this.category);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.update),
      onPressed: () =>
          Provider.of<ChildThProvider>(context).selectList(id, category),
    );
  }
}
