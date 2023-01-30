import 'package:docs_manager/frontend/components/contentPages/content_file_view.dart';
import 'package:docs_manager/frontend/pages/file_view.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import '../../../mock_classes/mocks.dart';

void main() {
  late ContentFileView sut;
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
      home: FileViewPage(sut, mockAppBar, mockDrawer, fileName: "testFile"),
    );
  }

  testWidgets("File view test functions", (tester) async {
    //when(()=>mockGoogle.addCalendarExpiration).thenAnswer((_) => AlertMessage(true, "Event added in calendar"))
    sut = ContentFileView("File Test", mockReadDB, mockUpdateDB, mockDeleteDB,
        mockGoogle, mockAlert);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byKey(const Key("edit")));
    await tester.pump();
    /* await tester.tap(find.byKey(const Key("drive")));
    await tester.pump();
    await tester.tap(find.byKey(const Key("add-calendar")));
    await tester.pump();*/
    await tester.tap(find.byKey(const Key("remove-calendar")));
    await tester.pump();
    await tester.tap(find.byKey(const Key("fav")));
    await tester.pump();
    await tester.tap(find.byKey(const Key("del")));
    await tester.pump();

    expect(find.byIcon(Icons.mode_edit_outline_rounded), findsOneWidget);
    expect(find.byIcon(Icons.add_to_drive_rounded), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    expect(find.byIcon(Icons.delete_rounded), findsOneWidget);
    expect(find.byIcon(Icons.open_in_new_rounded), findsOneWidget);
  });
}
