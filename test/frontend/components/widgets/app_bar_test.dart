import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
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
      title, isVisibleBackButton, backContext, isLogged, m1, m2, m3) {
    return MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(
            title, isVisibleBackButton, backContext, isLogged, m1, m2, m3),
      ),
    );
  }

  m1(backContext) {}
  m2(backContext, str) {}
  m3(backContext) {}
  testWidgets(
    "appbar has title",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest("MyTitle", true, context, false, m1, m2, m3));
      expect(find.text("MyTitle"), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
  testWidgets(
    "appbar has back button",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest("MyTitle", true, context, false, m1, m2, m3));
      await tester.tap(find.byKey(const Key("back")));
      await tester.pump();
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
    },
  );
  testWidgets(
    "appbar has home button",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest("MyTitle", false, context, false, m1, m2, m3));
      await tester.tap(find.byKey(const Key("home")));
      await tester.pump();
      expect(
          find.image(Image.asset("assets/images/LogoTransparentBig.png").image),
          findsOneWidget);
    },
  );
  testWidgets(
    "appbar has sign-out if logged",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest("MyTitle", false, context, true, m1, m2, m3));
      await tester.tap(find.byKey(const Key("logout")));
      await tester.pump();
      expect(find.byIcon(Icons.logout_rounded), findsOneWidget);
    },
  );
  testWidgets(
    "appbar hasn't sign-out if not logged",
    (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetUnderTest("MyTitle", false, context, false, m1, m2, m3));
      expect(find.byIcon(Icons.logout_rounded), findsNothing);
    },
  );
}
