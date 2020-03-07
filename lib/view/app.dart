import 'package:flutter_channel/service/auth_service.dart';
import 'package:flutter_channel/view/flutter_ch_home/home.dart';
import 'package:flutter_channel/view/importer.dart';

class FlutterChApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isAuthenticated() ? FlutterChHome() : Login(),
    );
  }

  bool isAuthenticated() {
    var svc = AuthService();
    bool isAuth = svc.chceckAuthenticated();
    return isAuth;
  }
}
