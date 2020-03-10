import 'package:flutter_channel/service/auth_service.dart';
import 'package:flutter_channel/view/importer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool auth = await isAuthenticated();
  runApp(FlutterChApp(auth));
}

Future<bool> isAuthenticated() async {
  var svc = AuthService();
  String uid = await svc.chceckAuthenticated();

  if (uid == null) {
    return false;
  } else {
    return true;
  }
}
