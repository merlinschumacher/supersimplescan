// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Super Simple Scan';

  @override
  String get scanStartButton => 'Mulai pindai';

  @override
  String get scanResultTitle => 'Hasil pindaian';

  @override
  String get enterFileNamePrompt => 'Masukkan judul untuk dokumen';

  @override
  String get fileNameIsRequired => 'Nama file wajib diisi';

  @override
  String get shareButton => 'Bagikan';

  @override
  String defaultFileName(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jms(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString $timeString Pindaian';
  }

  @override
  String get infoPageTextFile => 'info_id.md';

  @override
  String aboutDialogLegalese(DateTime year) {
    final intl.DateFormat yearDateFormat = intl.DateFormat.y(localeName);
    final String yearString = yearDateFormat.format(year);

    return '© 2024 - $yearString Merlin Schumacher';
  }
}
