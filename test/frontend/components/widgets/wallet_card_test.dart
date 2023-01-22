import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late FileModel file;

  setUp(() {
    context = MockBuildContext();
    file = FileModel(
        path: ["MyTestPath.png"],
        categoryName: "MyTestCat",
        isFavourite: false,
        dateUpload: "",
        extension: ["png"],
        expiration: "2030-05-16");
  });
  Widget createWidgetUnderTest(
      fileName, expiration, file, function, initCardFromDB) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              WalletCard(fileName, expiration, file, function, initCardFromDB),
            ],
          ),
        ],
      )),
    );
  }

  void method1(fileName, context) {}
  void initCardFromDB(
      n, categoryName, fileName, str, cardImage, context, bol, setImage) {
    setImage(Image.asset("assets/images/Logo.png"));
  }

  testWidgets(
    "category overview card displays correctly",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
          "FileTest", file.expiration, file, method1, initCardFromDB));
      await tester.tap(find.byKey(const Key("tap-widget")));
      await tester.pump();
      expect(find.byKey(const Key("tap-widget")), findsOneWidget);
    },
  );
}
