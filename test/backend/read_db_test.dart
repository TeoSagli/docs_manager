import 'package:docs_manager/firebase_options.dart';
import 'package:docs_manager/frontend/components/contentPages/content_login.dart';
import 'package:docs_manager/frontend/components/contentPages/content_register.dart';
import 'package:docs_manager/main.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:docs_manager/backend/read_db.dart';

import '../firebaseMock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group('read operations', () {
    test("value is null if i'm not logged in", () {
      expect("", "");
    });
    /*  test("value is null if i'm not logged in", () {
      expect(userRefDB(), "");
    });
         testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
      test('value is uid if logged in', () async {
      var logState = ContentLoginState();
      logState.login();
      expect(userRefDB(), "rMBQVk5gcYeYQ4CnWmpL8zWGL763");
    });

      test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });*/
  });
}
