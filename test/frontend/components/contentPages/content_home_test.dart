import 'package:carousel_slider/carousel_slider.dart';
import 'package:docs_manager/frontend/components/contentPages/content_home.dart';
import 'package:docs_manager/frontend/pages/home.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:docs_manager/others/constants.dart' as constants;
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentHome sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;
  late MockBottomBar mockBottomBar;
  late MockDrawer mockDrawer;
  late MockFileCard mockFileCard;
  late MockListCard mockListCard;
  late MockCategoryOverviewCard mockCategoryOverviewCard;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
    mockBottomBar = MockBottomBar();
    mockDrawer = MockDrawer();
    mockListCard = MockListCard();
    mockFileCard = MockFileCard();
    mockCategoryOverviewCard = MockCategoryOverviewCard();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: HomePage(sut, mockAppBar, mockBottomBar, mockDrawer));
  }

  init1(fulfillFileCards, b, c, d, e) {
    List<Widget> myCardsGrid = [];
    List<Widget> myCardsList = [];

    fulfillFileCards(myCardsGrid, myCardsList);
  }

  init2(fulfillCategoriesCards, moveToCategory) {
    List<Container> myCards = [];
    List<int> myOrders = [];
    fulfillCategoriesCards(myCards, myOrders);
  }

  retrieveAllFilesDB(
      fulfillFileCards, moveToFile, moveToEditFile, removeFileCard, e) {
    List<Widget> myCardsGrid = [mockFileCard];
    List<Widget> myCardsList = [mockListCard];
    fulfillFileCards(myCardsGrid, myCardsList);
    moveToFile("test", context);
    moveToEditFile("test", context);
    //TODO
    //removeFileCard(mockFileCard);
  }

  retrieveCategoryOverviewDB(fulfillCategoriesCards, moveToCategory) {
    List<Container> myCards = [];
    List<int> myOrders = [];
    myCards.add(Container(child: mockCategoryOverviewCard));
    myOrders.add(0);
    moveToCategory("test", context);
    fulfillCategoriesCards(myCards, myOrders);
  }

  navigateTo(a, b) {}
  deleteFileDB(a, b) {}
  deleteFileStorage(a, b, c) {}
  onUpdateNFilesDB(a) {}
  testWidgets("home content structure empty", (tester) async {
    sut = ContentHome(
      init1,
      init2,
      navigateTo,
      deleteFileDB,
      deleteFileStorage,
      onUpdateNFilesDB,
    );
    await tester.pumpWidget(createWidgetUnderTest());
    final titleFinder = find.text("All Categories");
    final subtitleFinder = find.text("Recent Files");
    final imageFinder =
        find.image(Image.asset('assets/images/No_docs.png').image);

    expect(titleFinder, findsOneWidget);
    expect(subtitleFinder, findsOneWidget);
    expect(imageFinder, findsOneWidget);
  });
  testWidgets("home content structure with cards", (tester) async {
    sut = ContentHome(
      retrieveAllFilesDB,
      retrieveCategoryOverviewDB,
      navigateTo,
      deleteFileDB,
      deleteFileStorage,
      onUpdateNFilesDB,
    );
    await tester.pumpWidget(createWidgetUnderTest());
    final titleFinder = find.text("All Categories");
    final carouselFinder = find.byType(CarouselSlider);
    final subtitleFinder = find.text("Recent Files");
    final modeChangerFinder = find.byKey(const Key("mode-change"));
    final imageFinder =
        find.image(Image.asset('assets/images/No_docs.png').image);

    expect(titleFinder, findsOneWidget);
    expect(carouselFinder, findsOneWidget);
    expect(subtitleFinder, findsOneWidget);
    expect(modeChangerFinder, findsOneWidget);
    expect(imageFinder, findsNothing);
  });
  testWidgets(
    "test change mode ",
    (WidgetTester tester) async {
      sut = ContentHome(
        retrieveAllFilesDB,
        retrieveCategoryOverviewDB,
        navigateTo,
        deleteFileDB,
        deleteFileStorage,
        onUpdateNFilesDB,
      );
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byTooltip("List"));
      await tester.pump();
      await tester.tap(find.byTooltip("Grid"));
      await tester.pump();
      expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
      expect(find.byIcon(Icons.view_list_rounded), findsOneWidget);
    },
  );
}
