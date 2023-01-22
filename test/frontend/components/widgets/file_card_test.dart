import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late FileModel file;
  setUp(() {
    context = MockBuildContext();
    file = FileModel(
        path: ["MyTestPath.png"],
        categoryName: "MyTestCat",
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
      initCardFromDB,
      initColorFromDB,
      updateFavouriteDB,
      onDeleteFile) {
    return MaterialApp(
        home: Scaffold(
            body: FileCard(
                fileName,
                file,
                function,
                moveToEditFilePage,
                removeCard,
                initCardFromDB,
                initColorFromDB,
                updateFavouriteDB,
                onDeleteFile)));
  }

  void method1(fileName, context) {}
  void updateFavouriteDB(categoryName, fileName, isFav) {}
  void moveToEditFilePage(fileName, context) {}
  void removeCard(el) {}
  void onDeleteFile(context, removeCard, widget) {}
  void initColorFromDB(setColor, categoryName) {
    setColor(4282682111);
  }

  initCardFromDB(
      ind, categoryName, fileName, ext, cardImage, context, bol, setImage) {
    setImage(Image.asset("assets/images/Logo.png"));
  }

  testWidgets(
    "show file card elements",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
          "Random stuff",
          file,
          method1,
          moveToEditFilePage,
          removeCard,
          initCardFromDB,
          initColorFromDB,
          updateFavouriteDB,
          onDeleteFile));
      await tester.tap(find.byKey(const Key("tap-card")));
      await tester.pump();
      await tester.tap(find.byKey(const Key("tap-move-to-edit")));
      await tester.pump();
      await tester.tap(find.byKey(const Key("tap-del")));
      await tester.pump();
      expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
      await tester.tap(find.byKey(const Key("tap-set-fav")));
      await tester.pump();
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
      expect(find.text("MyTestCat"), findsOneWidget);
      expect(find.text("Random stuff"), findsOneWidget);
    },
  );
}
