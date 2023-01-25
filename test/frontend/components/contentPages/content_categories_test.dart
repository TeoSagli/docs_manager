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

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
    mockBottomBar = MockBottomBar();
    mockDrawer = MockDrawer();
    mockCategoryCard = MockCategoryCard();
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
    sut = ContentCategories(retrieveCategoriesDB, updateOrderDB,
        deleteCategoryDB, deleteCategoryStorage, navigateTo);
    await tester.pumpWidget(createWidgetUnderTest());
    // tester.state(find.byType(State<ContentCategories>)).dispose();
    /* await longPressDrag(tester, tester.getCenter(find.byKey(const Key('0'))),
        tester.getCenter(find.byKey(const Key('1'))));
    await tester.pump();*/
    final textFinder = find.text("Group here your documents");

    expectLater(
      textFinder,
      findsOneWidget,
    );
  });
  /* testWidgets(
    "test change mode ",
    (WidgetTester tester) async {
    sut = ContentWallet(retrieveAllExpirationFilesDB, deleteFileDB,
        deleteFileStorage, onUpdateNFilesDB);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byTooltip("List"));
      await tester.pump();
      await tester.tap(find.byTooltip("Grid"));
      await tester.pump();
      expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
      expect(find.byIcon(Icons.view_list_rounded), findsOneWidget);
    },
  );*/
}
