import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_file_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock_classes/mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late MockAlert mockAlert;
  late MockUpdateDB mockUpdateDB;
  late MockGoogle mockGoogle;
  setUp(() {
    context = MockBuildContext();
    mockAlert = MockAlert();
    mockUpdateDB = MockUpdateDB();
    mockGoogle = MockGoogle();
  });
  Widget createWidgetUnderTest(
    fileName,
    file,
    moveToEditFilePage,
    removeCard,
    drive,
    addCalendar,
    remCalendar,
  ) {
    return MaterialApp(
      home: Scaffold(
        body: ButtonsFileOperations(
            fileName,
            file,
            moveToEditFilePage,
            removeCard,
            mockUpdateDB,
            drive,
            addCalendar,
            remCalendar,
            mockAlert),
      ),
    );
  }

  void moveToEditFilePage(fileName, context) {}
  void removeCard(card) {}

  void drive(file) {}
  void addCalendar(file) {}
  void remCalendar() {}

  testWidgets(
    "test buttons triggers operations and is not favourite",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("Test", fModel2,
          moveToEditFilePage, removeCard, drive, addCalendar, remCalendar));
      await tester.tap(find.byKey(const Key("edit")));
      await tester.tap(find.byKey(const Key("drive")));
      await tester.tap(find.byKey(const Key("add-calendar")));
      await tester.tap(find.byKey(const Key("remove-calendar")));
      await tester.tap(find.byKey(const Key("edit")));
      await tester.tap(find.byKey(const Key("fav")));
      await tester.tap(find.byKey(const Key("del")));
      await tester.pump();
      expect(find.byIcon(Icons.mode_edit_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.add_to_drive_rounded), findsOneWidget);
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
      expect(find.byIcon(Icons.delete_rounded), findsOneWidget);
    },
  );
  testWidgets(
    "test buttons triggers operations and is favourite",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("Test", fModel,
          moveToEditFilePage, removeCard, drive, addCalendar, remCalendar));
      await tester.tap(find.byKey(const Key("edit")));
      await tester.tap(find.byKey(const Key("fav")));
      await tester.tap(find.byKey(const Key("del")));
      await tester.pump();
      expect(find.byIcon(Icons.mode_edit_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.add_to_drive_rounded), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
      expect(find.byIcon(Icons.delete_rounded), findsOneWidget);

      // expect(find., findsOneWidget);
    },
  );
}
