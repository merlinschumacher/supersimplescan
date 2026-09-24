// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Super Simple Scan';

  @override
  String get scanStartButton => 'Почати сканування';

  @override
  String get scanResultTitle => 'Результат сканування';

  @override
  String get enterFileNamePrompt => 'Введіть назву документа';

  @override
  String get fileNameIsRequired => 'Ім\'я файлу обов\'язкове';

  @override
  String get shareButton => 'Поділитися';

  @override
  String defaultFileName(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jms(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString $timeString Скан';
  }

  @override
  String get infoPageTextFile => 'info_uk.md';

  @override
  String aboutDialogLegalese(DateTime year) {
    final intl.DateFormat yearDateFormat = intl.DateFormat.y(localeName);
    final String yearString = yearDateFormat.format(year);

    return '© 2024 - $yearString Merlin Schumacher';
  }
}
