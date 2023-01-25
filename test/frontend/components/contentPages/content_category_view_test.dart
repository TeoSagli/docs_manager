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
  late MockUpdateDB mockUpdateDB;
  late MockDeleteDB mockDeleteDB;
  late MockGoogle mockGoogle;
  late MockAlert mockAlert;

  setUpAll(() async {
    context = MockBuildContext();
    mockAlert = MockAlert();
    mockAppBar = MockAppBar();
    mockDrawer = MockDrawer();
    mockOperationsDB = MockOperationsDB();
    mockReadDB = mockOperationsDB.readDB;
    mockUpdateDB = mockOperationsDB.updateDB;
    mockDeleteDB = mockOperationsDB.deleteDB;
    mockGoogle = MockGoogle();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: CategoryViewPage(sut, mockAppBar, mockDrawer,
          catName: "testCategory"),
    );
  }

  testWidgets("Category test functions", (tester) async {
    //when(()=>mockGoogle.addCalendarExpiration).thenAnswer((_) => AlertMessage(true, "Event added in calendar"))
    sut = ContentCategoryView(
        "Credit Cards", mockReadDB, mockDeleteDB, mockUpdateDB, mockAlert);
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
    /* await tester.tap(find.byKey(
      const Key("tap-del"),
    ));
    await tester.pump();
     expect(find.image(Image.asset('assets/images/Credit Cards.png').image),
        findsOneWidget);
     expect(find.byIcon(Icons.mode_edit_outline_rounded), findsOneWidget);
    expect(find.byIcon(Icons.add_to_drive_rounded), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    expect(find.byIcon(Icons.delete_rounded), findsOneWidget);
    expect(find.byIcon(Icons.open_in_new_rounded), findsOneWidget);*/
  });
}
