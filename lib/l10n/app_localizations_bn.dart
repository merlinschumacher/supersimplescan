// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'Super Simple Scan';

  @override
  String get scanStartButton => 'স্ক্যান শুরু করুন';

  @override
  String get scanResultTitle => 'স্ক্যান ফলাফল';

  @override
  String get enterFileNamePrompt => 'নথির জন্য একটি শিরোনাম লিখুন';

  @override
  String get fileNameIsRequired => 'ফাইলের নাম আবশ্যক';

  @override
  String get shareButton => 'শেয়ার করুন';

  @override
  String defaultFileName(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jms(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString $timeString স্ক্যান';
  }

  @override
  String get infoPageTextFile => 'info_bn.md';

  @override
  String aboutDialogLegalese(DateTime year) {
    final intl.DateFormat yearDateFormat = intl.DateFormat.y(localeName);
    final String yearString = yearDateFormat.format(year);

    return '© 2024 - $yearString Merlin Schumacher';
  }
}
