import 'dart:async';
import 'package:docs_manager/frontend/components/contentPages/content_category_create.dart';
import 'package:docs_manager/frontend/pages/category_create.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentCategoryCreate sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;
  late MockDrawer mockDrawer;
  late MockReadDB mockReadDB;
  late MockCreateDB mockCreateDB;
  late MockAlert mockAlert;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
    mockDrawer = MockDrawer();
    mockAlert = MockAlert();
    mockReadDB = MockReadDB();
    mockCreateDB = MockCreateDB();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: CategoryCreatePage(sut, mockAppBar, mockDrawer),
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
    sut = ContentCategoryCreate(mockAlert, mockReadDB, mockCreateDB);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.text("Upload"));
    await tester.pump();
    final fintTxt = find.text('Category name:');

    expect(fintTxt, findsOneWidget);
  });
}
