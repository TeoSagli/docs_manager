import 'package:docs_manager/frontend/components/widgets/button_icon_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(text, fun, icon) {
    return MaterialApp(
      home: Scaffold(
        body: MyButtonIcon(text, fun, icon),
      ),
    );
  }

  void method() {}

  testWidgets(
    "button has name",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("Test", method, Icons.abc));
      expect(find.text("Test"), findsOneWidget);
      expect(find.byIcon(Icons.abc), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
  testWidgets(
    "button onclick triggers",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("Test", method, Icons.abc));
      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(find.byType(IconButton), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
}
