import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/frontend/components/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late CategoryModel category;
  setUp(() {
    context = MockBuildContext();
    category = CategoryModel(
        path: "assets/images/Credit Cards.png",
        nfiles: 0,
        colorValue: 0,
        order: 0);
  });
  Widget createWidgetUnderTest(categoryName, category, function,
      moveToEditCatPage, removeCard, initCardFromDB, onDelete) {
    return MaterialApp(
        home: Scaffold(
            body: CategoryCard(categoryName, category, function,
                moveToEditCatPage, removeCard, initCardFromDB, onDelete)));
  }

  void method1(a, b) {}
  void moveToEditCatPage(categoryName, context) {}
  void removeCard(el) {}
  void onDelete(context, removeCard, widget, a) {}
  void initCardFromDB(path, setCard) {
    rootBundle
        .load('assets/images/No_docs.png')
        .then((value) => setCard(value.buffer.asUint8List()));
  }

  testWidgets(
    "category is not immutable (no edit/delete)",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("Random stuff", category,
          method1, moveToEditCatPage, removeCard, initCardFromDB, onDelete));
      await tester.tap(find.byTooltip("Edit"));
      await tester.tap(find.byTooltip("Remove"));
      await tester.pump();
      expect(find.byIcon(Icons.mode_edit_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline_rounded), findsOneWidget);
    },
  );
  testWidgets(
    "category is immutable (no edit/delete)",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("Credit Cards", category,
          method1, moveToEditCatPage, removeCard, initCardFromDB, onDelete));
      await tester.tap(find.byKey(const Key("tap-widget")));
      await tester.pump();
      expect(find.byIcon(Icons.mode_edit_outline_rounded), findsNothing);
      expect(find.byIcon(Icons.delete_outline_rounded), findsNothing);
    },
  );
}
