import 'package:docs_manager/frontend/components/contentPages/content_login.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockAppBar extends Mock implements MyAppBar {
  @override
  Size get preferredSize => const Size(100, 100);
  @override
  String get title => "Login";

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
}

class MockContentLogin extends Mock implements ContentLogin {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
}

class MockContentLoginState extends State<MockContentLogin> {
  @override
  Widget build(BuildContext context) {
    var t = Text("Login");
    print("Oddio");
    print(t.data.toString());
    return t;
  }
}

void main() {
  late MockBuildContext context;
  late LoginPage sut;
  late MockContentLogin mockContent;
  late MockAppBar mockAppBar;
  late MockContentLoginState mockContentState;

  setUp(() {
    context = MockBuildContext();

    mockContent = MockContentLogin();
    mockAppBar = MockAppBar();
    sut = LoginPage(mockContent, mockAppBar);
    mockContentState = MockContentLoginState();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(home: sut);
  }

  /*test(
    "test",
    () async {
      when(() => mockContentWallet.toStringShort()).thenReturn("Wallet");
      sut.content.toStringShort();
      expect(find.text("Wallet"), findsOneWidget);
    },
  );*/
  testWidgets(
    "Wallet layout",
    (WidgetTester tester) async {
      var myState = tester.state(find.byType(ContentLogin));
      /*    
          // Stub the `sound` method.
          when(() => mockContent.createState())
          .thenReturn(MockContentLoginState());
      await tester.pumpWidget(createWidgetUnderTest());*/
      expect(find.text("Login"), findsOneWidget);
    },
  );
}
