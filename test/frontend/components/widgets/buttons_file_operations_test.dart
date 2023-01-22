import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_file_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late FileModel fm;
  late FileModel fm1;
  setUp(() {
    context = MockBuildContext();
    fm = FileModel(
        path: [],
        categoryName: "",
        isFavourite: false,
        dateUpload: "",
        extension: [],
        expiration: "");
    fm1 = FileModel(
        path: [],
        categoryName: "",
        isFavourite: true,
        dateUpload: "",
        extension: [],
        expiration: "");
  });
  Widget createWidgetUnderTest(
      fileName, file, moveToEditFilePage, removeCard, updateFav) {
    return MaterialApp(
      home: Scaffold(
        body: ButtonsFileOperations(
            fileName, file, moveToEditFilePage, removeCard, updateFav),
      ),
    );
  }

  void method1() {}
  void method2(fileName, context) {}
  void method3(context, method1, widget) {}
  void method4(categoryName, fileName, isFav) {}

  testWidgets(
    "test buttons triggers operations and is not favourite",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest("Test", fm, method2, method3, method4));
      await tester.tap(find.byKey(const Key("edit")));
      //TODO DRIVE CALL
      await tester.tap(find.byKey(const Key("fav")));
      await tester.tap(find.byKey(const Key("del")));
      await tester.pump();
      expect(find.byIcon(Icons.mode_edit_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.add_to_drive_rounded), findsOneWidget);
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
      expect(find.byIcon(Icons.delete_rounded), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
  testWidgets(
    "test buttons triggers operations and is favourite",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest("Test", fm1, method2, method3, method4));
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
