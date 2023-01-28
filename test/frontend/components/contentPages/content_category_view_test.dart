import 'package:docs_manager/frontend/components/contentPages/content_category_view.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_view_mode.dart';
import 'package:docs_manager/frontend/pages/category_view.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentCategoryView sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;
  late MockDrawer mockDrawer;
  late MockOperationsDB mockOperationsDB;
  late MockReadDB mockReadDB;
  late MockReadDB2 mockReadDB2;
  late MockUpdateDB mockUpdateDB;
  late MockDeleteDB mockDeleteDB;
  late MockAlert mockAlert;

  setUpAll(() async {
    context = MockBuildContext();
    mockAlert = MockAlert();
    mockAppBar = MockAppBar();
    mockReadDB2 = MockReadDB2();
    mockDrawer = MockDrawer();
    mockOperationsDB = MockOperationsDB();
    mockReadDB = mockOperationsDB.readDB;
    mockUpdateDB = mockOperationsDB.updateDB;
    mockDeleteDB = mockOperationsDB.deleteDB;
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: CategoryViewPage(sut, mockAppBar, mockDrawer,
          catName: "Credit Cards"),
    );
  }

  testWidgets("Category test functions ", (tester) async {
    sut = ContentCategoryView(
        "Credit Cards", mockReadDB2, mockDeleteDB, mockUpdateDB, mockAlert);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byTooltip("Grid"));
    await tester.pump();
    expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
    expect(find.byIcon(Icons.view_list_rounded), findsOneWidget);
    await tester.tap(find.byTooltip("List"));
    await tester.pump();
    expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
    expect(find.byIcon(Icons.view_list_rounded), findsOneWidget);
    expect(find.image(Image.asset('assets/images/Credit Cards.png').image),
        findsNothing);
    expect(find.byType(ViewMode), findsOneWidget);
  });
}
