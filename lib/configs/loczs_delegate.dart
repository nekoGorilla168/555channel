import 'package:flutter_channel/configs/localization.dart';
import 'package:flutter_channel/view/importer.dart';

class LoczsDelegate extends LocalizationsDelegate<Loczs> {
  const LoczsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ja'].contains(locale.countryCode);
  }

  @override
  Future<Loczs> load(Locale locale) {
    return Loczs.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Loczs> old) {
    return false;
  }
}
