import "package:docs_manager/frontend/components/contentPages/content_login.dart";
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import "package:docs_manager/frontend/pages/login.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

class MockBuildContext extends Mock implements BuildContext {}

class MockAppBar extends Mock implements MyAppBar {
  @override
  Size get preferredSize => const Size(100, 100);
  @override
  String get title => "Login";

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
}

void main() {
  late ContentLogin sut;
  late MockBuildContext context;
  late MockAppBar mockAppBar;

  setUpAll(() async {
    context = MockBuildContext();
    mockAppBar = MockAppBar();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(home: LoginPage(sut, mockAppBar));
  }

  onErrorGeneric() {}
  onErrorFirebase() {}
  moveToRegisterPage(a, b) {}
  onLoginConfirmed(a, b) {}
  Future<bool> handleLogin(um1, context, onErrorFirebase, onErrorGeneric) {
    return Future.value(true);
  }

  testWidgets("Login content structure", (tester) async {
    sut = ContentLogin(handleLogin, context, onErrorGeneric, onErrorFirebase,
        onLoginConfirmed, moveToRegisterPage);
    await tester.pumpWidget(createWidgetUnderTest());
    final titleFinder = find.text("Login to DocuManager!");
    final subtitleFinder = find.text("The simple documents & cards manager");
    final imageFinder =
        find.image(Image.asset("assets/images/Login.png").image);
    final buttonLoginText = find.text("Login");
    final buttonRegisterText = find.text("Register -->");

    expect(titleFinder, findsOneWidget);
    expect(subtitleFinder, findsOneWidget);
    expect(imageFinder, findsOneWidget);
    expect(buttonLoginText, findsWidgets);
    expect(buttonRegisterText, findsOneWidget);
  });

  testWidgets("Enter email", (tester) async {
    sut = ContentLogin(handleLogin, context, onErrorGeneric, onErrorFirebase,
        onLoginConfirmed, moveToRegisterPage);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byKey(const Key("email")), "MyName");
    await tester.pump();
    expect(find.text("MyName"), findsOneWidget);
    await tester.enterText(find.byKey(const Key("email")), "a@a.it");
    await tester.pump();
    expect(find.text("a@a.it"), findsOneWidget);
  });
  testWidgets("Enter password", (tester) async {
    sut = ContentLogin(handleLogin, context, onErrorGeneric, onErrorFirebase,
        onLoginConfirmed, moveToRegisterPage);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byKey(const Key("password")), "MyPassword");
    await tester.pump();
    expect(find.text("MyPassword"), findsOneWidget);
    await tester.enterText(find.byKey(const Key("password")), "123456");
    await tester.pump();
    expect(find.text("123456"), findsOneWidget);
  });
  testWidgets("Tap Login button", (tester) async {
    sut = ContentLogin(handleLogin, context, onErrorGeneric, onErrorFirebase,
        onLoginConfirmed, moveToRegisterPage);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.ensureVisible(find.byType(MyButton));
    await tester.pump();
    await tester.enterText(find.byKey(const Key("email")), "a@a.it");
    await tester.enterText(find.byKey(const Key("password")), "123456");
    await tester.tap(find.byType(MyButton));
    await tester.pump();
    expect(find.byType(MyButton), findsOneWidget);
  });
  testWidgets("Tap Register button", (tester) async {
    sut = ContentLogin(handleLogin, context, onErrorGeneric, onErrorFirebase,
        onLoginConfirmed, moveToRegisterPage);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.ensureVisible(find.byType(TextButton));
    await tester.pump();
    await tester.tap(find.byType(TextButton));
    await tester.pump();
    expect(find.byType(TextButton), findsOneWidget);
  });
}
