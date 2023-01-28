import 'dart:async';

import 'package:docs_manager/frontend/components/contentPages/content_category_edit.dart';
import 'package:docs_manager/frontend/pages/categories_edit.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentCategoryEdit sut;
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
      home: CategoryEditPage(
        sut,
        mockAppBar,
        mockDrawer,
        catName: "Credit Cards",
      ),
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
    sut = ContentCategoryEdit("Credit Cards", mockReadDB, mockCreateDB,
        mockUpdateDB, mockDeleteDB, mockAlert);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.text("Edit"));
    await tester.pump();
    final fintTxt = find.text('Category name:');

    expect(fintTxt, findsOneWidget);
  });
}
