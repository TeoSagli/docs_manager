import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(backContext, n) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: MyBottomBar(backContext, n),
      ),
    );
  }

  testWidgets(
    "bottombar items have labels",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(context, 0));
      expect(find.text("Home"), findsOneWidget);
      expect(find.text("Wallet"), findsOneWidget);
      expect(find.text("Categories"), findsOneWidget);
      expect(find.text("Favourites"), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
  testWidgets(
    "bottombar has home active",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(context, 0));
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(
          find.byIcon(Icons.account_balance_wallet_outlined), findsOneWidget);
      expect(find.byIcon(Icons.category_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite_outline_rounded), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
  testWidgets(
    "bottombar has wallet active",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(context, 1));
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(find.byIcon(Icons.account_balance_wallet_rounded), findsOneWidget);
      expect(find.byIcon(Icons.category_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite_outline_rounded), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
  testWidgets(
    "bottombar has categories active",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(context, 2));
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(
          find.byIcon(Icons.account_balance_wallet_outlined), findsOneWidget);
      expect(find.byIcon(Icons.category), findsOneWidget);
      expect(find.byIcon(Icons.favorite_outline_rounded), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
  testWidgets(
    "bottombar has favourites active",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(context, 3));
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(
          find.byIcon(Icons.account_balance_wallet_outlined), findsOneWidget);
      expect(find.byIcon(Icons.category_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    },
  );
}
