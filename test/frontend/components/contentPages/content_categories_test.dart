import 'dart:async';

import 'package:docs_manager/frontend/components/contentPages/content_categories.dart';
import 'package:docs_manager/frontend/pages/categories.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:mocktail/mocktail.dart';
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentCategories sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;
  late MockBottomBar mockBottomBar;
  late MockDrawer mockDrawer;
  late MockCategoryCard mockCategoryCard;
  late MockReadDB mockReadDB;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
    mockBottomBar = MockBottomBar();
    mockDrawer = MockDrawer();
    mockCategoryCard = MockCategoryCard();
    mockReadDB = MockReadDB();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: CategoriesPage(sut, mockAppBar, mockBottomBar, mockDrawer));
  }

  StreamSubscription retrieveCategoriesDB(
      fulfillCard, moveToFile, moveToEditCategory, removeCard) {
    List<Container> myCards = [
      Container(key: const Key('0'), child: mockCategoryCard),
      Container(key: const Key('1'), child: mockCategoryCard),
    ];
    List<int> myOrders = [0, 1];
    moveToFile("test", context);

    return Future.delayed(
            const Duration(seconds: 2), () => fulfillCard(myCards, myOrders))
        .asStream()
        .listen((_) => true);
  }

  navigateTo(a, b) {}
  updateOrderDB(a, b) {}
  deleteCategoryDB(a) {}
  deleteCategoryStorage(a, b) {}
  Future<void> longPressDrag(
      WidgetTester tester, Offset start, Offset end) async {
    final TestGesture drag = await tester.startGesture(start);
    await tester.pump();
    await drag.moveTo(end);
    await tester.pump();
    await drag.up();
  }

  testWidgets("wallet content structure ", (tester) async {
    sut = ContentCategories(mockReadDB.retrieveCategoriesDB, updateOrderDB,
        deleteCategoryDB, deleteCategoryStorage, navigateTo);
    await tester.pumpWidget(createWidgetUnderTest());
    final textFinder = find.text("Group here your documents");

    expectLater(
      textFinder,
      findsOneWidget,
    );
    tester.state(find.byType(State<ContentCategories>)).dispose();
  });
}
