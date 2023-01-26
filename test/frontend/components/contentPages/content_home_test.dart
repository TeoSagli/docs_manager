import 'package:carousel_slider/carousel_slider.dart';
import 'package:docs_manager/frontend/components/contentPages/content_home.dart';
import 'package:docs_manager/frontend/pages/home.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentHome sut;
  late MockAppBar mockAppBar;
  late MockBottomBar mockBottomBar;
  late MockDrawer mockDrawer;

  late MockReadDB mockReadDB;
  late MockReadDB2 mockReadDB2;
  late MockUpdateDB mockUpdateDB;
  late MockDeleteDB mockDeleteDB;
  late MockAlert mockAlert;

  setUpAll(() async {
    mockAppBar = MockAppBar();
    mockBottomBar = MockBottomBar();
    mockDrawer = MockDrawer();
    mockReadDB = MockReadDB();
    mockReadDB2 = MockReadDB2();
    mockUpdateDB = MockUpdateDB();
    mockDeleteDB = MockDeleteDB();
    mockAlert = MockAlert();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: HomePage(sut, mockAppBar, mockBottomBar, mockDrawer));
  }

  testWidgets("home content structure empty", (tester) async {
    sut = ContentHome(
      mockReadDB,
      mockDeleteDB,
      mockUpdateDB,
      mockAlert,
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
      mockReadDB2,
      mockDeleteDB,
      mockUpdateDB,
      mockAlert,
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
        mockReadDB2,
        mockDeleteDB,
        mockUpdateDB,
        mockAlert,
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
  testWidgets(
    "test removeCard",
    (WidgetTester tester) async {
      sut = ContentHome(
        mockReadDB2,
        mockDeleteDB,
        mockUpdateDB,
        mockAlert,
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.ensureVisible(find.byKey(const Key("tap-del")));
      await tester.pump();
      await tester.tap(find.byKey(const Key("tap-del")));

      expect(find.byKey(const Key("tap-del")), findsOneWidget);
    },
  );
}
