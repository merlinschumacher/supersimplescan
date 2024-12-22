import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:super_simple_scan/views/document_result_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

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
    return MaterialApp(
      title: 'Super Simple Scan',
      theme: FlexThemeData.light(
          appBarElevation: 0.5,
          useMaterial3: true,
          typography:
              Typography.material2021(platform: TargetPlatform.android)),
      darkTheme: FlexThemeData.dark(
          appBarElevation: 1,
          useMaterial3: true,
          typography:
              Typography.material2021(platform: TargetPlatform.android)),
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
      home: HomePage(title: "Super Simple Scan"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DocumentScanner? _documentScanner;
  DocumentScanningResult? _result;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startScan());
  }

  void startScan() async {
    try {
      _result = null;
      _documentScanner = DocumentScanner(
          options: DocumentScannerOptions(
        documentFormat: DocumentFormat.pdf,
        mode: ScannerMode.base,
        pageLimit: 100,
        isGalleryImport: false,
      ));
      _result = await _documentScanner!.scanDocument();
      print('Result: $_result');
      setState(() {});
      if (!mounted) return;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DocumentResultView(document: _result!)));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton.icon(
              onPressed: startScan,
              label: Text(AppLocalizations.of(context)!.scanStartButton),
              icon: Icon(Icons.camera_alt),
              style: FilledButton.styleFrom(
                textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                padding: EdgeInsets.symmetric(horizontal: 34, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
