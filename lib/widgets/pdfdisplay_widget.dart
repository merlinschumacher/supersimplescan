import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfDisplayWidget extends StatefulWidget {
  final String pdfUrl;

  const PdfDisplayWidget({super.key, required this.pdfUrl});

  @override
  PdfDisplayWidgetState createState() => PdfDisplayWidgetState();
}

class PdfDisplayWidgetState extends State<PdfDisplayWidget> {
  int currentPage = 0;
  int? totalPages = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PDFView(
        enableSwipe: true,
        pageFling: true,
        pageSnap: true,
        autoSpacing: true,
        filePath: widget.pdfUrl,
        defaultPage: currentPage,
        swipeHorizontal: true,
        fitPolicy: FitPolicy.BOTH,
        fitEachPage: true,
        preventLinkNavigation: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onRender: (pages) {
          setState(() {
            totalPages = pages;
            isReady = true;
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
                Theme.of(context).scaffoldBackgroundColor.withAlpha(0),
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
    ]);
  }
}
