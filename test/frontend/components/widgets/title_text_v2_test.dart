import 'package:docs_manager/frontend/components/widgets/button_icon_function.dart';
import 'package:docs_manager/frontend/components/widgets/title_text_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(
    text,
  ) {
    return MaterialApp(
      home: Scaffold(
        body: TitleText2(
          text,
        ),
      ),
    );
  }

  testWidgets(
    "text is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        "Test",
      ));
      expect(find.text("Test"), findsOneWidget);
    },
  );
}
