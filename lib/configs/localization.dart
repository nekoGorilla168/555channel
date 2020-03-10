import 'package:flutter_channel/configs/loczs_delegate.dart';
import 'package:flutter_channel/view/importer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class Loczs {
  static Future<Loczs> load(Locale locale) async {
    final nm = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();

    final localeNm = Intl.canonicalizedLocale(nm);

    // await initializeMessages();
    Intl.defaultLocale = localeNm;

    return Loczs();
  }

  static Loczs of(BuildContext context) {
    return Localizations.of<Loczs>(context, Loczs);
  }

  static const LocalizationsDelegate<Loczs> delegate = LoczsDelegate();

  // String get
}
