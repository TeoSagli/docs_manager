import 'package:docs_manager/frontend/components/contentPages/content_register.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:docs_manager/frontend/pages/register.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

class MockBuildContext extends Mock implements BuildContext {}

class MockAppBar extends Mock implements MyAppBar {
  @override
  Size get preferredSize => const Size(100, 100);
  @override
  String get title => "Register";

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
}

void main() {
  late ContentRegister sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(home: RegisterPage(sut, mockAppBar));
  }

  setUser(a) {}
  handleRegister(context) {}

  testWidgets("Register content structure", (tester) async {
    sut = ContentRegister(handleRegister, setUser, context);
    await tester.pumpWidget(createWidgetUnderTest());
    final titleFinder = find.text("Register an account!");
    final subtitleFinder = find.text("Choose an email and a password");
    final imageFinder =
        find.image(Image.asset('assets/images/Registration.png').image);
    final buttonRegisterText = find.text("Register");

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(subtitleFinder, findsOneWidget);
    expect(imageFinder, findsOneWidget);
    expect(buttonRegisterText, findsWidgets);
  });

  testWidgets("Enter email", (tester) async {
    sut = ContentRegister(handleRegister, setUser, context);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byKey(const Key("email")), "MyName");
    await tester.pump();
    expect(find.text("MyName"), findsOneWidget);
    await tester.enterText(find.byKey(const Key("email")), "a@a.it");
    await tester.pump();
    expect(find.text("a@a.it"), findsOneWidget);
  });
  testWidgets("Enter password", (tester) async {
    sut = ContentRegister(handleRegister, setUser, context);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byKey(const Key("password")), "MyPassword");
    await tester.pump();
    expect(find.text("MyPassword"), findsOneWidget);
    await tester.enterText(find.byKey(const Key("password")), "123456");
    await tester.pump();
    expect(find.text("123456"), findsOneWidget);
  });
  testWidgets("Tap Register button", (tester) async {
    sut = ContentRegister(handleRegister, setUser, context);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.ensureVisible(find.byType(MyButton));
    await tester.pump();
    await tester.enterText(find.byKey(const Key("email")), "a@a.it");
    await tester.enterText(find.byKey(const Key("password")), "123456");
    await tester.tap(find.byType(MyButton));
    await tester.pump();
    expect(find.byType(MyButton), findsOneWidget);
  });
}
