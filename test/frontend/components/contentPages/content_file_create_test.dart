import 'dart:async';
import 'package:docs_manager/frontend/components/contentPages/content_file_create.dart';
import 'package:docs_manager/frontend/components/widgets/input_field.dart';
import 'package:docs_manager/frontend/pages/file_create.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentFileCreate sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;
  late MockDrawer mockDrawer;

  late MockAlert mockAlert;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
    mockDrawer = MockDrawer();
    mockAlert = MockAlert();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: FileCreatePage(sut, mockAppBar, mockDrawer, ""),
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

  checkElementExistDB(a, b, setBool) {
    setBool(false);
  }

  retrieveCategoriesNamesDB(a) {}
  createFile(catName, text, dateText, listPaths, listExt, s) {}
  loadFileToStorage(path, text, saveName, dropdownValue) {}
  onUpdateNFilesDB(dropdownValue) {}

  testWidgets("Create empty file structure", (tester) async {
    sut = ContentFileCreate("", checkElementExistDB, retrieveCategoriesNamesDB,
        createFile, loadFileToStorage, onUpdateNFilesDB, mockAlert);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byKey(const Key("tap-date")));
    await tester.pump();
    final fintTxt = find.text("File name:");

    expect(fintTxt, findsOneWidget);
  });
  testWidgets("Tap file pickers", (tester) async {
    sut = ContentFileCreate("", checkElementExistDB, retrieveCategoriesNamesDB,
        createFile, loadFileToStorage, onUpdateNFilesDB, mockAlert);
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
    sut = ContentFileCreate("", checkElementExistDB, retrieveCategoriesNamesDB,
        createFile, loadFileToStorage, onUpdateNFilesDB, mockAlert);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byType(InputField), "My doc");
    await tester.pump();
    await tester.tap(find.byIcon(Icons.photo_camera));
    await tester.pump();
    await tester.ensureVisible(find.text('Submit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Submit'));
    await tester.pump();
    final fintTxt = find.text("Submit");

    expect(fintTxt, findsOneWidget);
  });
}
