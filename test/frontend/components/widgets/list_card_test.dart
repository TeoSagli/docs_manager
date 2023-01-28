import 'dart:async';

import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';
import 'package:docs_manager/frontend/components/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock_classes/mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late FileModel file;

  setUp(() {
    context = MockBuildContext();
    file = FileModel(
        path: ["Credit Cards.png"],
        categoryName: "Credit Cards",
        isFavourite: false,
        dateUpload: "",
        extension: ["png"],
        expiration: "");
  });

  Widget createWidgetUnderTest(
      fileName,
      file,
      function,
      moveToEditFilePage,
      removeCard,
      updateFavouriteDB,
      onDeleteFile,
      readImageCategoryStorage,
      getCatModelFromCatNameDB) {
    return MaterialApp(
        home: Scaffold(
            body: ListCard(
      fileName,
      file,
      function,
      moveToEditFilePage,
      removeCard,
      updateFavouriteDB,
      onDeleteFile,
      readImageCategoryStorage,
      getCatModelFromCatNameDB,
    )));
  }

  void method1(fileName, context) {}
  void moveToEditFilePage(fileName, context) {}
  void removeCard(el) {}
  void onDeleteFile(context, removeCard, widget) {}
  void updateFavouriteDB(categoryName, fileName, isFav) {}
  void getCatModelFromCatNameDB(a, b) {}
  void readImageCategoryStorage(
    categoryName,
    setCard,
  ) {}

  testWidgets(
    "show list card elements and favourite",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
          "Random stuff",
          file,
          method1,
          moveToEditFilePage,
          removeCard,
          updateFavouriteDB,
          onDeleteFile,
          readImageCategoryStorage,
          getCatModelFromCatNameDB));
      await tester.tap(find.byKey(const Key("move-to")));
      await tester.pump();
      await tester.tap(find.byKey(const Key("move-to-2")));
      await tester.pump();
      await tester.tap(find.byKey(const Key("tap-del")));
      await tester.pump();

      expect(find.text("Random stuff"), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
    },
  );
  testWidgets(
    "show list card elements and not favourite",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
          "Random stuff",
          file,
          method1,
          moveToEditFilePage,
          removeCard,
          updateFavouriteDB,
          onDeleteFile,
          readImageCategoryStorage,
          getCatModelFromCatNameDB));
      await tester.tap(find.byKey(const Key("set-fav")));
      await tester.pump();
      expect(find.text("Random stuff"), findsOneWidget);
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    },
  );
}
