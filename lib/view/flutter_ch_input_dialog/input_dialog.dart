import 'package:flutter/rendering.dart';
import 'package:flutter_channel/provider/genre_chip_state.dart';
import 'package:flutter_channel/view/importer.dart';

class InputDialog extends ModalRoute<void> {
  final Widget contents;

  final bool isBackBtn;

  InputDialog(this.contents, {this.isBackBtn = true}) : super();

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => false;
  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);
  @override
  String get barrierLabel => null;
  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(child: _buildOverlay(context)),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Center(
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return WillPopScope(
        child: ChangeNotifierProvider<GenreChipState>(
          create: (_) => GenreChipState(),
          child: Consumer<GenreChipState>(builder: (context, value, child) {
            return this.contents;
          }),
        ),
        onWillPop: () {
          return Future(() => isBackBtn);
        });
  }
}
