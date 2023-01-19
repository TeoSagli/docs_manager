import "dart:convert";

import 'package:docs_manager/backend/models/user.dart';
import "package:docs_manager/frontend/components/contentPages/content_login.dart";
import "package:docs_manager/frontend/components/widgets/title_text.dart";
import "package:docs_manager/frontend/pages/login.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_auth_mocks/firebase_auth_mocks.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:docs_manager/others/constants.dart" as constants;
import "package:mockito/mockito.dart";
import "../../../firebaseMock.dart";

void main() {
  late LoginPage loginPage;
  late MockUser user1;
  late MockUser user2;
  late UserCredsModel um1;
  late UserCredsModel um2;

  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
    final Map<String, dynamic> json1 = {"password": "", "email": ""};
    final Map<String, dynamic> json2 = {
      "password": "a@a.it",
      "email": "123456"
    };
    um1 = UserCredsModel.fromJson(json1);
    um2 = UserCredsModel.fromJson(json2);
    loginPage = const LoginPage();
    //when(mock.signIn(authInst)).thenAnswer((_) async => true);
  });

  testWidgets("Login content structure", (tester) async {
    Widget buildTestableWidget(Widget widget) {
      return MediaQuery(
          data: const MediaQueryData(), child: MaterialApp(home: widget));
    }

    await tester.pumpWidget(buildTestableWidget(loginPage));
    final titleFinder = find.text("Login to DocuManager!");
    final subtitleFinder = find.text("The simple documents & cards manager");
    final imageFinder =
        find.image(Image.asset("assets/images/Login.png").image);
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
  group("login tests", () {
    test("login failed", () async {
      /* final auth = MockFirebaseAuth(mockUser: user1);
      try {
        auth
            .signInWithEmailAndPassword(
                email: um1.email, password: um1.password)
            .onError((error, stackTrace) {
          print("Error is $error");
          return (um1 as UserCredential);
        });
        print("success");
      } on FirebaseException catch (e) {
        print("Error is $e");
      }
      expect(false, false);*/
    });

    test("login valid", () async {
      /*
      final auth = MockFirebaseAuth(mockUser: user2);
      sut = HandleSignInMock(auth, um1.email, um1.password);
      final bool hasLogged = await sut.signIn();
      expect(hasLogged, true);
      */
    });
  });
}
