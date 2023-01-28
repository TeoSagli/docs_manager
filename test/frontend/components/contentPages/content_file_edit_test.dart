import 'dart:async';
import 'package:docs_manager/frontend/components/contentPages/content_file_edit.dart';
import 'package:docs_manager/frontend/components/widgets/input_field.dart';
import 'package:docs_manager/frontend/pages/file_edit.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentFileEdit sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;
  late MockDrawer mockDrawer;
  late MockReadDB2 mockReadDB;
  late MockCreateDB mockCreateDB;
  late MockDeleteDB mockDeleteDB;
  late MockUpdateDB mockUpdateDB;
  late MockAlert mockAlert;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
    mockDrawer = MockDrawer();
    mockAlert = MockAlert();
    mockReadDB = MockReadDB2();
    mockCreateDB = MockCreateDB();
    mockUpdateDB = MockUpdateDB();
    mockDeleteDB = MockDeleteDB();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: FileEditPage(sut, mockAppBar, mockDrawer, fileName: "MyFile"),
    );
  }

  StreamSubscription init(
      fulfillCard, moveToFile, moveToEditFile, removeFileCard, bol) {
    List<Widget> myCardsGrid = [];
    List<Widget> myCardsList = [];
    fulfillCard(myCardsGrid, myCardsList);
    return Future.delayed(const Duration(seconds: 2),
            () => fulfillCard(myCardsGrid, myCardsList))
        .asStream()
        .listen((_) => true);
  }

  testWidgets("Create empty file structure", (tester) async {
    sut = ContentFileEdit(
        "", mockReadDB, mockCreateDB, mockUpdateDB, mockDeleteDB, mockAlert);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byKey(const Key("tap-date")));
    await tester.pump();
    final fintTxt = find.text("File name:");

    expect(fintTxt, findsOneWidget);
  });
  testWidgets("Tap file pickers", (tester) async {
    sut = ContentFileEdit(
        "", mockReadDB, mockCreateDB, mockUpdateDB, mockDeleteDB, mockAlert);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byIcon(Icons.photo_camera));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.image));
    await tester.pump();
    /* await tester.tap(find.byIcon(Icons.picture_as_pdf));
    await tester.pump();*/
    final fintTxt = find.text("File name:");

    expect(fintTxt, findsOneWidget);
  });
  testWidgets("Submit file from camera", (tester) async {
    sut = ContentFileEdit(
        "", mockReadDB, mockCreateDB, mockUpdateDB, mockDeleteDB, mockAlert);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byType(InputField), "My doc");
    await tester.pump();
    await tester.tap(find.byIcon(Icons.photo_camera));
    await tester.pump();
    await tester.ensureVisible(find.text('Edit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pump();
    final fintTxt = find.text("Edit");

    expect(fintTxt, findsOneWidget);
  });
}
