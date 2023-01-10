import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:docs_manager/frontend/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import '../../../firebaseMock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  testWidgets('Login content structure', (tester) async {
    Widget buildTestableWidget(Widget widget) {
      return MediaQuery(
          data: const MediaQueryData(), child: MaterialApp(home: widget));
    }

    await tester.pumpWidget(buildTestableWidget(const LoginPage()));
    final titleFinder = find.text("Login to DocuManager!");
    final subtitleFinder = find.text("The simple documents & cards manager");
    final imageFinder =
        find.image(Image.asset('assets/images/Login.png').image);
    final buttonLoginText = find.text("Login");
    final buttonRegisterText = find.text("Register -->");

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(subtitleFinder, findsOneWidget);
    expect(imageFinder, findsOneWidget);
    expect(buttonLoginText, findsWidgets);
    expect(buttonRegisterText, findsOneWidget);
  });
}
