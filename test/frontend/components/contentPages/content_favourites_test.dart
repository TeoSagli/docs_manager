import 'dart:async';
import 'package:docs_manager/frontend/components/contentPages/content_favourites.dart';
import 'package:docs_manager/frontend/pages/favourites.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentFavourites sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;
  late MockBottomBar mockBottomBar;
  late MockDrawer mockDrawer;
  late MockFileCard mockFileCard;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
    mockBottomBar = MockBottomBar();
    mockDrawer = MockDrawer();
    mockFileCard = MockFileCard();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: FavouritesPage(sut, mockAppBar, mockBottomBar, mockDrawer));
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

  StreamSubscription retrieveAllFilesDB(
      fulfillCard, moveToFile, moveToEditFile, removeFileCard, bol) {
    List<Container> myCards = [
      Container(key: const Key('0'), child: mockFileCard),
      Container(key: const Key('1'), child: mockFileCard),
    ];

    List<int> myOrders = [0, 1];
    moveToFile("test", context);
    moveToEditFile("test", context);
//TODO
//removeFileCard
    return Future.delayed(
            const Duration(seconds: 2), () => fulfillCard(myCards, myOrders))
        .asStream()
        .listen((_) => true);
  }

  navigateTo(a, b) {}
  updateOrderDB(a, b) {}
  deleteCategoryDB(a) {}
  deleteCategoryStorage(a, b) {}

  testWidgets("favourites empty structure", (tester) async {
    sut = ContentFavourites(init, updateOrderDB, deleteCategoryDB,
        deleteCategoryStorage, navigateTo);
    await tester.pumpWidget(createWidgetUnderTest());
    // tester.state(find.byType(State<ContentCategories>)).dispose();
    /* await longPressDrag(tester, tester.getCenter(find.byKey(const Key('0'))),
        tester.getCenter(find.byKey(const Key('1'))));
    await tester.pump();*/
    final findImg = find.image(Image.asset('assets/images/No_fav.png').image);

    expectLater(
      findImg,
      findsOneWidget,
    );
  });
  testWidgets("favourites complete structure ", (tester) async {
    sut = ContentFavourites(retrieveAllFilesDB, updateOrderDB, deleteCategoryDB,
        deleteCategoryStorage, navigateTo);
    await tester.pumpWidget(createWidgetUnderTest());
    final textFinder = find.text("Your favourite docs will be here");

    expectLater(
      textFinder,
      findsOneWidget,
    );
  });
}
