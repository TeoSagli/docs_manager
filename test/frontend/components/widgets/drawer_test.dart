import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late GlobalKey<ScaffoldState> scaffoldKey;

  setUp(() {
    context = MockBuildContext();
    scaffoldKey = GlobalKey<ScaffoldState>();
  });
  Widget createWidgetUnderTest(onAccountStatus, onSettings) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: MyDrawer(onAccountStatus, onSettings),
        body: Text("Hello"),
      ),
    );
  }

  onAccountStatus(context) {}
  onSettings(context) {}
  testWidgets(
    "drawer displays correctly and tap account",
    (WidgetTester tester) async {
      await tester
          .pumpWidget(createWidgetUnderTest(onAccountStatus, onSettings));
      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("account")));
      await tester.pumpAndSettle();
      expect(find.text("Account"), findsOneWidget);
      expect(find.text("Settings"), findsOneWidget);
    },
  );
  testWidgets(
    "drawer displays correctly and tap settings",
    (WidgetTester tester) async {
      await tester
          .pumpWidget(createWidgetUnderTest(onAccountStatus, onSettings));
      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("settings")));
      await tester.pumpAndSettle();
      expect(find.text("Account"), findsOneWidget);
      expect(find.text("Settings"), findsOneWidget);
    },
  );
}
