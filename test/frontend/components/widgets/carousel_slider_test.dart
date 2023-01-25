import 'package:docs_manager/frontend/components/widgets/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  late MyCarousel sut;

  setUp(() {
    context = MockBuildContext();
  });

  Widget createWidgetUnderTest(List<Image> previewImgList, removeImage,
      showRemove, List<String> exts, m, catName, fileName) {
    return MaterialApp(
      home: Scaffold(
        body: MyCarousel(
          previewImgList,
          showRemove,
          removeImg: removeImage,
          extensions: exts,
          moveToOpenFile: m,
          catName: catName,
          fileName: fileName,
        ),
      ),
    );
  }

  void method1(item) {}
  void method2(fileName, catName, currImgIndex) {}
  void method3() {}
  testWidgets(
    "empty state",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
          [], method1, false, [], method2, "testcname", "testfname"));
      expect(find.byWidget(constants.loadingWheel2), findsOneWidget);
    },
  );
  testWidgets(
    "pdf in carousel",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
          [
            Image.asset(
              "assets/images/LogoTransparentBig.png",
            )
          ],
          method1,
          false,
          ["pdf"],
          method2,
          "testcname",
          "testfname"));
      await tester.ensureVisible(find.byIcon(Icons.open_in_new_rounded));
      await tester.tap(
        find.byIcon(Icons.open_in_new_rounded),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.open_in_new_rounded), findsOneWidget);
    },
  );
  testWidgets(
    "remove pdf",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
          [
            Image.asset("assets/images/LogoTransparentBig.png",
                height: 50, width: 50),
          ],
          method1,
          true,
          ["png"],
          method2,
          "testcname",
          "testfname"));
      await tester.tap(find.byKey(const Key("delete-pdf")));
      await tester.pump();
      expect(find.byIcon(Icons.open_in_new_rounded), findsNothing);
    },
  );
}
