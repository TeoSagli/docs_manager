import 'package:docs_manager/frontend/components/widgets/input_field.dart';
import 'package:docs_manager/frontend/components/widgets/widget_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext context;
  setUp(() {
    context = MockBuildContext();
  });
  Widget createWidgetUnderTest(
    loadedImage,
    cardSize,
    removeImage,
  ) {
    return MaterialApp(
      home: Scaffold(
        body: DocumentPreview(
          loadedImage,
          cardSize,
          removeImage,
        ),
      ),
    );
  }

  removeImage(card) {}
  testWidgets(
    "preview an image",
    (WidgetTester tester) async {
      var image = Image(
        image: Image.asset('assets/images/Logo.png').image,
        fit: BoxFit.fitWidth,
      );
      await tester.pumpWidget(createWidgetUnderTest(image, 200.0, removeImage));
      expect(find.image(Image.asset('assets/images/Logo.png').image),
          findsOneWidget);
      expect(find.textContaining("Remove"), findsOneWidget);
    },
  );
  testWidgets(
    "remove the preview",
    (WidgetTester tester) async {
      var image = Image(
        image: Image.asset('assets/images/Logo.png').image,
        fit: BoxFit.fitWidth,
      );
      await tester.pumpWidget(createWidgetUnderTest(image, 200.0, removeImage));
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      expect(find.textContaining("Remove"), findsOneWidget);
    },
  );
}
