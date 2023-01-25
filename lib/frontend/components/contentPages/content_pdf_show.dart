import 'package:docs_manager/others/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class ContentPdfShow extends StatefulWidget {
  final String fName;
  final String cName;
  final String fIndex;
  final dynamic readFileFromNameStorage;
  const ContentPdfShow(
      this.fName, this.cName, this.fIndex, this.readFileFromNameStorage,
      {super.key});

  @override
  State<ContentPdfShow> createState() => StateContentPdfShow();
}

class StateContentPdfShow extends State<ContentPdfShow> {
  late Future<PdfDocument> doc;
  bool isPdfSet = false;
  @override
  void initState() {
    widget.readFileFromNameStorage(
        widget.fIndex, widget.fName, widget.cName, openFile);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isPdfSet == true
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PdfView(
              controller: PdfController(document: doc),
            ),
          )
        : constants.loadingWheel;
  }

  //========================================================
  //open file: if fromBytes is true is loaded from bytes elese it's a pdf already
  openFile(dynamic doc, bool fromBytes) {
    if (fromBytes) {
      setPdf(PdfDocument.openData(doc));
    } else {
      setPdf(doc);
    }
  }

  //========================================================
  setPdf(Future<PdfDocument> d) {
    setState(() {
      isPdfSet = true;
      doc = d;
    });
  }
}
