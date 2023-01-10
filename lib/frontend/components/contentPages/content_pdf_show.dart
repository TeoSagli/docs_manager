import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class ContentPdfShow extends StatefulWidget {
  final String fName;
  final String cName;
  final String fIndex;
  const ContentPdfShow(this.fName, this.cName, this.fIndex, {super.key});

  @override
  State<ContentPdfShow> createState() => StateContentPdfShow();
}

class StateContentPdfShow extends State<ContentPdfShow> {
  late Future<PdfDocument> doc;
  bool isPdfSet = false;
  @override
  void initState() {
    readFileFromNameStorage(widget.fIndex, widget.fName, widget.cName, setFile);
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
  openFile(Uint8List pdfFile) {
    Future<PdfDocument> d = PdfDocument.openData(pdfFile);
    setState(() {
      isPdfSet = true;
      doc = d;
    });
  }

  //========================================================
  setFile(Uint8List data) {
    openFile(data);
  }
  //========================================================
}
