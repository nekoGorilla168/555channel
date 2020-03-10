import 'package:flutter_channel/configs/thread_constants.dart';
import 'package:flutter_channel/provider/child_thread_provider.dart';
import 'package:flutter_channel/provider/genre_chip_state.dart';
import 'package:flutter_channel/view/flutter_ch_input_dialog/input_dialog.dart';
import 'package:flutter_channel/view/importer.dart';

class CustomDialog {
  BuildContext context;
  String parentId;
  String category;

  // 選択したジャンルのリスト
  List<String> genreList = [];

  CustomDialog(this.context, this.parentId, this.category) : super();
  final titleCntrl = TextEditingController();
  final textCntrl = TextEditingController();

  // ダイアログ表示
  void ShowCustomDialog() {
    final _thPrv = Provider.of<ChildThProvider>(context, listen: false);
    final _genre = Provider.of<GenreChipState>(context, listen: false);

    Navigator.push(
      context,
      InputDialog(
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Wrap(
                    children: _getFilterChipList(_genre),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: titleCntrl,
                    maxLength: 30,
                    maxLines: 1,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: "スレッドタイトル"),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: textCntrl,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: "書き込み"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: FlatButton(
                        onPressed: () => hidden(),
                        child: Text(
                          "キャンセル",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: FlatButton(
                        onPressed: () {
                          _thPrv.addThread(
                              parentId,
                              category,
                              _genre.getGenreList,
                              titleCntrl.text,
                              textCntrl.text);
                          _thPrv.selectList(parentId, category);
                          _genre.getGenreList.clear();
                          hidden();
                        },
                        child: Text(
                          "スレ立て",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        isBackBtn: true,
      ),
    );
  }

  void hidden() {
    Navigator.of(context).pop();
  }

  String selectedGenre(List list) {
    String name = "";
    for (var item in list) {
      name += item;
    }
    return name;
  }

  // フィルターチップのリストを返す
  List<Widget> _getFilterChipList(GenreChipState genre) {
    List<Widget> filterChipList = ThreadCons.GENRE.map((genreNm) {
      return Transform.scale(
        scale: 0.85,
        child: FilterChip(
          label: Text(genreNm),
          selected: genre.getGenreList.contains(genreNm),
          backgroundColor: Colors.blueGrey.shade100,
          checkmarkColor: Colors.blueAccent,
          selectedColor: Colors.lightBlueAccent.shade100,
          onSelected: (bool selected) {
            if (selected) {
              genre.setGenre(genreNm);
            } else {
              genre.removeGenre(genreNm);
            }
          },
        ),
      );
    }).toList();

    return filterChipList;
  }
}
