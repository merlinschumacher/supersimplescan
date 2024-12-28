import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:super_simple_scan/views/document_result_view.dart';
import 'package:super_simple_scan/widgets/customappbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.appName),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton.icon(
              onPressed: startScan,
              label: Text(AppLocalizations.of(context)!.scanStartButton),
              icon: Icon(Icons.document_scanner, size: 40),
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
