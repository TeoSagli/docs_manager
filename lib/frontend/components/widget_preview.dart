import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class DocumentPreview extends StatefulWidget {
  const DocumentPreview({super.key});

  @override
  State<StatefulWidget> createState() => DocumentPreviewState();
}

class DocumentPreviewState extends State<DocumentPreview> {
  late PDFDocument document = PDFDocument();
  @override
  void initState() {
    //document.count = 1;
    //getPDF('docs/SezioneAurea.pdf');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional(1, -1),
      children: [
        Align(
          alignment: AlignmentDirectional(1, 0),
          child: PDFViewer(document: document),
        ),
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: IconButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            )),
            icon: const Icon(
              Icons.delete,
              color: Color(0xFFFF0000),
              size: 30,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ),
      ],
    );
  }
/*
  getPDF(String url) {
    setState(() {
      PDFDocument.fromAsset(url).then((value) => {document = value});
    });
  }*/
}
