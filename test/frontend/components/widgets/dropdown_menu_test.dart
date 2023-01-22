import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/frontend/components/widgets/category_overview_card.dart';
import 'package:docs_manager/frontend/components/widgets/dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockCategoryModel extends Mock implements CategoryModel {}

void main() {
  late MockBuildContext context;
  late CategoryModel category;

  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(categoryName, initCardFromDB) {
    return MaterialApp(
      home: Scaffold(
        body: MyDropdown(categoryName, initCardFromDB),
      ),
    );
  }

  void initCardFromDB(fillCategoriesNames) {
    List<String> list = ["1", "2", "3"];
    fillCategoriesNames(list);
  }

  testWidgets(
    "dropdown sets values",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("", initCardFromDB));

      expect(find.text("1"), findsOneWidget);
      expect(find.text("2"), findsOneWidget);
      expect(find.text("3"), findsOneWidget);
    },
  );
  testWidgets(
    "dropdown sets new first value",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("2", initCardFromDB));
      await tester.tap(find.byType(MyDropdown));
      await tester.pumpAndSettle();
      final dropdownItem = find.text('2').last;
      await tester.tap(dropdownItem);
      expect(find.text("1"), findsNWidgets(2));
      expect(find.text("2"), findsNWidgets(2));
      expect(find.text("3"), findsNWidgets(2));
    },
  );
}
