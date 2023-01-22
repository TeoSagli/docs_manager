import 'package:docs_manager/frontend/components/widgets/button_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(pageContext, linkNav, icon, tooltip, func) {
    return MaterialApp(
      home: Scaffold(
        body: ButtonAdd(pageContext, linkNav, icon, tooltip, func),
      ),
    );
  }

  void func(
    pageContext,
    linkNav,
  ) {}

  testWidgets(
    "button is displayed correctly",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest(context, "/", Icons.abc, "Test", func));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.abc), findsOneWidget);
    },
  );
}
