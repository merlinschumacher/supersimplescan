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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppbarWidget(),
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