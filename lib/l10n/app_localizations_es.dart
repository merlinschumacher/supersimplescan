// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Super Simple Scan';

  @override
  String get scanStartButton => 'Iniciar escaneo';

  @override
  String get scanResultTitle => 'Resultado del escaneo';

  @override
  String get enterFileNamePrompt => 'Introduce un título para el documento';

  @override
  String get fileNameIsRequired => 'El nombre del archivo es obligatorio';

  @override
  String get shareButton => 'Compartir';

  @override
  String defaultFileName(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jms(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString $timeString Escaneo';
  }

  @override
  String get infoPageTextFile => 'info_es.md';

  @override
  String aboutDialogLegalese(DateTime year) {
    final intl.DateFormat yearDateFormat = intl.DateFormat.y(localeName);
    final String yearString = yearDateFormat.format(year);

    return '© 2024 - $yearString Merlin Schumacher';
  }
}
