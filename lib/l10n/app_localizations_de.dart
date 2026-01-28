// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Super Simple Scan';

  @override
  String get scanStartButton => 'Scan starten';

  @override
  String get scanResultTitle => 'Scan-Ergebnis';

  @override
  String get enterFileNamePrompt =>
      'Geben Sie einen Titel für das Dokument ein';

  @override
  String get fileNameIsRequired => 'Der Dateiname ist erforderlich';

  @override
  String get shareButton => 'Teilen';

  @override
  String defaultFileName(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jms(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString $timeString Scan';
  }

  @override
  String get infoPageTextFile => 'info_de.md';

  @override
  String aboutDialogLegalese(DateTime year) {
    final intl.DateFormat yearDateFormat = intl.DateFormat.y(localeName);
    final String yearString = yearDateFormat.format(year);

    return '© 2024 - $yearString Merlin Schumacher';
  }
}
