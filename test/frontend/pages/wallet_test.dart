import 'package:docs_manager/frontend/components/contentPages/content_wallet.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:docs_manager/frontend/pages/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockAppBar extends Mock implements MyAppBar {
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(100, 100);
  @override // TODO: implement title
  String get title => "Wallet";

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "";
  }
}

class MockBottomBar extends Mock implements MyBottomBar {
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "";
  }
}

class MockDrawer extends Mock implements MyDrawer {
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "";
  }
}

class MockContentWallet extends Mock implements ContentWallet {
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "";
  }

  @override
  State<ContentWallet> createState() => MockContentWalletState();
}

class MockContentWalletState extends State<MockContentWallet> {
  @override
  Widget build(BuildContext context) {
    var t = Text("Wallet");
    print("Oddio");
    print(t.data.toString());
    return t;
  }
}

void main() {
  late MockBuildContext context;
  late WalletPage sut;
  late MockContentWallet mockContentWallet;
  late MockAppBar mockAppBar;
  late MockBottomBar mockBottomBar;
  late MockDrawer mockDrawer;
  late MockContentWalletState mockContentWalletState;

  setUp(() {
    context = MockBuildContext();

    mockContentWallet = MockContentWallet();
    mockAppBar = MockAppBar();
    mockBottomBar = MockBottomBar();
    mockDrawer = MockDrawer();
    sut = WalletPage(mockContentWallet, mockAppBar, mockBottomBar, mockDrawer);
    mockContentWalletState = MockContentWalletState();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(home: sut);
  }

  test(
    "test",
    () async {
      when(() => mockContentWallet.toStringShort()).thenReturn("Wallet");
      sut.content.toStringShort();
      expect(find.text("Wallet"), findsOneWidget);
    },
  );
  testWidgets(
    "Wallet layout",
    (WidgetTester tester) async {
      // Stub the `sound` method.
      when(() => mockContentWallet.toStringShort()).thenReturn("Wallet");
      await tester.pumpWidget(createWidgetUnderTest());
      sut.content.toStringShort();
      expect(find.text("Wallet"), findsOneWidget);
    },
  );
}
