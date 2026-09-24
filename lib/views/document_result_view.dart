import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:super_simple_scan/l10n/app_localizations.dart';
import 'package:super_simple_scan/widgets/customappbar_widget.dart';
import 'package:super_simple_scan/widgets/filenameform_widget.dart';
import 'package:super_simple_scan/widgets/pdfdisplay_widget.dart';

class DocumentResultView extends StatefulWidget {
  final DocumentScanningResult document;

  DocumentResultView({super.key, required this.document});

  @override
  DocumentResultViewState createState() => DocumentResultViewState();
}

class DocumentResultViewState extends State<DocumentResultView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fileNameFieldController = TextEditingController(text: "");

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fileNameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double contentHeight = screenHeight - appBarHeight;
    double pdfHeight = contentHeight * 0.7;

    return Scaffold(
      appBar:
          CustomAppBar(title: AppLocalizations.of(context)!.scanResultTitle),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                  height: pdfHeight,
                  child: PdfDisplayWidget(pdfUrl: widget.document.pdf!.uri)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            FileNameFormWidget(
                formKey: _formKey,
                fileNameFieldController: fileNameFieldController,
                onSubmitted: _shareDocument,
                defaultFileName: _getDefaultFileName()),
          ],
        ),
      ),
    );
  }

  // Add a pdf suffix to the file name if it is missing
  String _addPdfSuffix(String fileName) {
    // Remove leading and trailing whitespaces
    fileName = fileName.trim();
    if (!fileName.toLowerCase().endsWith('.pdf')) {
      return '$fileName.pdf';
    }
    return fileName;
  }

  String _getDefaultFileName() {
    DateTime now = DateTime.now();
    return AppLocalizations.of(context)!.defaultFileName(now, now);
  }

  void _shareDocument() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String fileName = _addPdfSuffix(fileNameFieldController.text);
    SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(widget.document.pdf!.uri, mimeType: 'application/pdf'),
        ],
        fileNameOverrides: [fileName],
      ),
    );
  }
}
