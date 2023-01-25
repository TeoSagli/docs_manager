import 'package:docs_manager/frontend/components/contentPages/content_pdf_show.dart';
import 'package:docs_manager/frontend/pages/view_pdf.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:pdfx/pdfx.dart';
import '../../../mock_classes/mocks.dart';
import 'package:docs_manager/others/constants.dart' as constants;

void main() {
  late ContentPdfShow sut;
  late MockAppBar mockAppBar;
  late MockDrawer mockDrawer;

  setUpAll(() async {
    mockAppBar = MockAppBar();
    mockDrawer = MockDrawer();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: PdfShow(sut, mockAppBar, mockDrawer),
    );
  }

  init(fName, cName, fIndex, openFile) {}

  readFileFromNameStorage(fName, cName, fIndex, openFile) {
    var value = PdfDocument.openAsset('assets/pdfs/sample.pdf');
    Uint8List bytes = Uint8List(1);
    openFile(bytes, true);
    openFile(value, false);
  }

  testWidgets("Create empty file structure", (tester) async {
    sut = ContentPdfShow("testFile", "testCat", "0", init);
    await tester.pumpWidget(createWidgetUnderTest());
    final findLoad = find.byWidget(constants.loadingWheel);

    expect(findLoad, findsOneWidget);
  });
  testWidgets("Create complete structure", (tester) async {
    sut = ContentPdfShow("testFile", "testCat", "0", readFileFromNameStorage);
    await tester.pumpWidget(createWidgetUnderTest());
    final findLoad = find.byWidget(constants.loadingWheel);

    expect(findLoad, findsNothing);
  });
}
