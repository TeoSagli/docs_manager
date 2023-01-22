import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/frontend/components/widgets/category_overview_card.dart';
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
        path: "assets/images/No_docs.png", nfiles: 0, colorValue: 0, order: 0);
  });
  Widget createWidgetUnderTest(
      categoryName, category, function, initCardFromDB) {
    return MaterialApp(
      home: Scaffold(
        body: CategoryOverviewCard(
            categoryName, category, function, initCardFromDB),
      ),
    );
  }

  void method1(categoryName, context) {}
  void initCardFromDB(path, setCard) {
    rootBundle
        .load('assets/images/No_docs.png')
        .then((value) => setCard(value.buffer.asUint8List()));
  }

  testWidgets(
    "category overview card displays correctly",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest("CatTest", category, method1, initCardFromDB));
      await tester.tap(find.byKey(const Key("tap-widget")));
      await tester.pump();
      expect(find.text("CatTest"), findsOneWidget);
      expect(find.byKey(const Key("tap-widget")), findsOneWidget);
    },
  );
}
