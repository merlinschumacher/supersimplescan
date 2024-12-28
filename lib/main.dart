import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:super_simple_scan/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const SuperSimpleScan());
}

class SuperSimpleScan extends StatelessWidget {
  const SuperSimpleScan({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
      final ColorScheme lightColorScheme =
          _generateColorScheme(lightDynamic?.primary);
      final ColorScheme darkColorScheme =
          _generateColorScheme(darkDynamic?.primary, Brightness.dark);
      return MaterialApp(
        title: 'Super Simple Scan',
        theme: ThemeData(colorScheme: lightColorScheme),
        darkTheme: ThemeData(colorScheme: darkColorScheme),
        themeMode: ThemeMode.system,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('de'),
        ],
        home: HomePage(),
      );
    });
  }

// Workaround for https://github.com/material-foundation/flutter-packages/issues/582
  ColorScheme _generateColorScheme(Color? primaryColor,
      [Brightness? brightness]) {
    final Color seedColor = primaryColor ?? Colors.blue;

    final ColorScheme newScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness ?? Brightness.light,
    );

    return newScheme.harmonized();
  }
}
