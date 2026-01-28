// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Super Simple Scan';

  @override
  String get scanStartButton => 'Start scan';

  @override
  String get scanResultTitle => 'Scan result';

  @override
  String get enterFileNamePrompt => 'Enter a title for the document';

  @override
  String get fileNameIsRequired => 'The file name is required';

  @override
  String get shareButton => 'Share';

  @override
  String defaultFileName(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jms(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString $timeString Scan';
  }

  @override
  String get infoPageTextFile => 'info_en.md';

  @override
  String aboutDialogLegalese(DateTime year) {
    final intl.DateFormat yearDateFormat = intl.DateFormat.y(localeName);
    final String yearString = yearDateFormat.format(year);

    return '© 2024 - $yearString Merlin Schumacher';
  }
}
