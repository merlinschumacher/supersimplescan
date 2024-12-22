import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:share_plus/share_plus.dart';

class DocumentResultView extends StatefulWidget {
  final DocumentScanningResult document;

  DocumentResultView({super.key, required this.document});

  @override
  DocumentResultViewState createState() => DocumentResultViewState();
}

class DocumentResultViewState extends State<DocumentResultView>
    with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fileNameFieldController = TextEditingController(text: "");
  int currentPage = 0;
  int? totalPages = 0;
  bool isReady = false;
  String errorMessage = '';

// Add a pdf suffix to the file name if it is missing
  String _addPdfSuffix(String fileName) {
    if (!fileName.toLowerCase().endsWith('.pdf')) {
      return '$fileName.pdf';
    }
    return fileName;
  }

  void setDefaultFileName() {
    DateTime now = DateTime.now();
    fileNameFieldController.text =
        AppLocalizations.of(context)!.defaultFileName(now, now);
    fileNameFieldController.selection = TextSelection(
        baseOffset: 0, extentOffset: fileNameFieldController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double contentHeight = screenHeight - appBarHeight;
    double pdfHeight = contentHeight * 0.7;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.scanResultTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                  height: pdfHeight,
                  child: Stack(children: [
                    PDFView(
                      enableSwipe: true,
                      pageFling: true,
                      pageSnap: true,
                      autoSpacing: true,
                      filePath: widget.document.pdf!.uri,
                      defaultPage: currentPage,
                      swipeHorizontal: true,
                      fitPolicy: FitPolicy.BOTH,
                      fitEachPage: true,
                      preventLinkNavigation: false,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      onRender: (pages) {
                        setState(() {
                          totalPages = pages;
                          isReady = true;
                          setDefaultFileName();
                        });
                      },
                      onPageChanged: (page, total) {
                        setState(() {
                          currentPage = page ?? 0;
                          totalPages = total;
                        });
                      },
                      onPageError: (page, error) {
                        setState(() {
                          errorMessage = '$page: ${error.toString()}';
                        });
                        print('$page: ${error.toString()}');
                      },
                    ),
                    errorMessage.isEmpty
                        ? !isReady
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container()
                        : Center(
                            child: Text(errorMessage),
                          ),
                    Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width - 32,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withAlpha(0),
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                          ),
                        ),
                        child: Text(
                          "${currentPage + 1} / $totalPages",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: fileNameFieldController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.enterFileNamePrompt,
                      suffixText: '.pdf',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.fileNameIsRequired;
                      }
                      return null;
                    },
                    onTap: () => fileNameFieldController.selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: fileNameFieldController.text.length),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: FilledButton.icon(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _shareDocument(widget.document.pdf!,
                              _addPdfSuffix(fileNameFieldController.text));
                        }
                      },
                      label: Text(AppLocalizations.of(context)!.shareButton),
                      icon: Icon(Icons.share),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = File.fromUri(myUri);
    Uint8List? bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:$onError');
    });
    return bytes;
  }

  void _shareDocument(
      DocumentScanningResultPdf document, String fileName) async {
    Uint8List? bytes = await _readFileByte(document.uri);
    if (bytes == null) {
      return;
    }
    Share.shareXFiles(
      [XFile.fromData(bytes, name: fileName, mimeType: 'application/pdf')],
      fileNameOverrides: [fileName],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fileNameFieldController.dispose();
    super.dispose();
  }
}
