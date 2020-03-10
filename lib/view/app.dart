import 'package:flutter_channel/configs/localization.dart';
import 'package:flutter_channel/configs/loczs_delegate.dart';
import 'package:flutter_channel/provider/child_thread_provider.dart';
import 'package:flutter_channel/provider/genre_chip_state.dart';
import 'package:flutter_channel/provider/show_search_bar.dart';
import 'package:flutter_channel/view/flutter_ch_home/home.dart';
import 'package:flutter_channel/view/importer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/number_symbols_data.dart';

class FlutterChApp extends StatelessWidget {
  final bool authenticated;
  FlutterChApp(this.authenticated);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: authenticated ? FlutterChHome() : Login(),
      localizationsDelegates: [
        Loczs.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
      ],
    );
  }
}
