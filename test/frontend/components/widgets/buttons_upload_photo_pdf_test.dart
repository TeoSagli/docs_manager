import 'package:docs_manager/frontend/components/widgets/buttons_upload_photo_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;

  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(f1, f2, f3) {
    return MaterialApp(
      home: Scaffold(
        body: ButtonsUploadPhotoes(f1, f2, f3),
      ),
    );
  }

  void method1() {}
  void method2() {}
  void method3() {}

  testWidgets(
    "button has name",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(method1, method2, method3));
      expect(find.byIcon(Icons.photo_camera), findsOneWidget);
      expect(find.byIcon(Icons.image), findsOneWidget);
      expect(find.byIcon(Icons.picture_as_pdf), findsOneWidget);
      // expect(find., findsOneWidget);
    },
  );
}
