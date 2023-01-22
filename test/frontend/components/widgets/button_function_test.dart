import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(text, fun) {
    return MaterialApp(
      home: Scaffold(
        body: MyButton(text, fun),
      ),
    );
  }

  void method() {}

  testWidgets(
    "button has name",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("Test", method));
      expect(find.text("Test"), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
  testWidgets(
    "button onclick triggers",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest("Test", method));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(ElevatedButton), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
}
