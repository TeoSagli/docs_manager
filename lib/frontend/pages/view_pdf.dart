import 'dart:io';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfShow extends StatefulWidget {
  final String fName;
  final String cName;
  final String fIndex;
  const PdfShow(this.fName, this.cName, this.fIndex, {super.key});

  @override
  State<PdfShow> createState() => StatePdfShow();
}

class StatePdfShow extends State<PdfShow> {
  late Future<PdfDocument> doc;
  bool isPdfSet = false;
  @override
  void initState() {
    readFileFromNameStorage(widget.fIndex, widget.fName, widget.cName, setFile);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar('View pdf N° ${widget.fIndex}', true, context),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: isPdfSet == true
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: PdfView(
                        controller: PdfController(document: doc),
                      ),
                    )
                  : constants.loadingWheel)
        ],
      ),
    );
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
