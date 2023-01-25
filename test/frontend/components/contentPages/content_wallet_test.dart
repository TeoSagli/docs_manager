import 'package:docs_manager/frontend/components/contentPages/content_wallet.dart';
import 'package:docs_manager/frontend/pages/wallet.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:docs_manager/others/constants.dart' as constants;
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentWallet sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;
  late MockBottomBar mockBottomBar;
  late MockDrawer mockDrawer;
  late MockWalletCard mockWalletCard;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
    mockBottomBar = MockBottomBar();
    mockDrawer = MockDrawer();
    mockWalletCard = MockWalletCard();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: WalletPage(sut, mockAppBar, mockBottomBar, mockDrawer));
  }

  init1(fulfillCard, moveToFile) {
    List<Widget> myCardsGrid = [];

    fulfillCard(myCardsGrid);
  }

  retrieveAllExpirationFilesDB(
    fulfillCard,
    moveToFile,
  ) {
    List<Widget> myCards = [mockWalletCard];

    fulfillCard(myCards);
    moveToFile("test", context);
    //TODO
    //removeFileCard(mockFileCard);
  }

  navigateTo(a, b) {}
  testWidgets("wallet content structure empty", (tester) async {
    sut = ContentWallet(init1, navigateTo);
    await tester.pumpWidget(createWidgetUnderTest());
    final imageFinder =
        find.image(Image.asset('assets/images/Wallet_empty.png').image);

    expect(imageFinder, findsOneWidget);
  });

  testWidgets("wallet content structure with cards", (tester) async {
    sut = ContentWallet(retrieveAllExpirationFilesDB, navigateTo);
    await tester.pumpWidget(createWidgetUnderTest());
    final titleFinder = find.text("Expiring documents will be here");

    expect(titleFinder, findsOneWidget);
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
