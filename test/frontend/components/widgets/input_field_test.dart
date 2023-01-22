import 'package:docs_manager/frontend/components/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late TextEditingController t1;
  setUp(() {
    context = MockBuildContext();
    t1 = TextEditingController();
  });
  Widget createWidgetUnderTest(tc, isTitle) {
    return MaterialApp(
      home: Scaffold(
        body: InputField(tc, isTitle),
      ),
    );
  }

  testWidgets(
    "input long description",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(t1, true));
      expect(find.textContaining("30"), findsOneWidget);
    },
  );
  testWidgets(
    "input short description",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(t1, false));
      expect(find.textContaining("100"), findsOneWidget);
    },
  );
  testWidgets(
    "text changed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(t1, true));
      await tester.enterText(find.byType(TextFormField), "Hello");
      await tester.pump();
      expect(find.textContaining("Hello"), findsOneWidget);
    },
  );
}
