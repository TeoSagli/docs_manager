import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late final scaffoldKey;

  setUp(() {
    context = MockBuildContext();
    scaffoldKey = GlobalKey<ScaffoldState>();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: const MyDrawer(),
        body: Text("Hello"),
      ),
    );
  }

  testWidgets(
    "drawer displays correctly",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      scaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.ensureVisible(find.byKey(const Key("account")));
      await tester.tap(find.byKey(const Key("account")));
      await tester.pump();
      await tester.ensureVisible(find.text("Back"));
      await tester.tap(find.text("Back"));
      await tester.pump();
      await tester.tap(find.byKey(const Key("settings")));
      await tester.pump();
      expect(find.text("Account"), findsOneWidget);
      expect(find.text("Settings"), findsOneWidget);
    },
  );
}
