import 'package:docs_manager/frontend/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../firebaseMock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  testWidgets('Register content structure', (tester) async {
    Widget buildTestableWidget(Widget widget) {
      return MediaQuery(
          data: const MediaQueryData(), child: MaterialApp(home: widget));
    }

    await tester.pumpWidget(buildTestableWidget(const RegisterPage()));
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
}
