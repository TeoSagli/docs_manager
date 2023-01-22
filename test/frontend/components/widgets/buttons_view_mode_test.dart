import 'package:docs_manager/frontend/components/widgets/buttons_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(viewMode, n) {
    return MaterialApp(
      home: Scaffold(
        body: ViewMode(viewMode, n),
      ),
    );
  }

  void method1(n) {}

  testWidgets(
    "button in mode grid",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(method1, 0));
      await tester.tap(find.byTooltip("Grid"));
      await tester.pump();
      expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
      expect(find.byIcon(Icons.view_list_rounded), findsOneWidget);
    },
  );
  testWidgets(
    "button in mode list",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(method1, 1));
      await tester.tap(find.byTooltip("List"));
      await tester.pump();
      expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
      expect(find.byIcon(Icons.view_list_rounded), findsOneWidget);
    },
  );
}
