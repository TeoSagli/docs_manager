import 'package:docs_manager/frontend/components/contentPages/content_wallet.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../components/widgets/app_bar.dart';

class WalletPage extends StatelessWidget {
  final ContentWallet content;
  final MyAppBar myAppBar;
  final MyBottomBar myBottomBar;
  final MyDrawer myDrawer;
  const WalletPage(this.content, this.myAppBar, this.myBottomBar, this.myDrawer,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar,
      bottomNavigationBar: myBottomBar,
      drawer: myDrawer,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: content,
          )
        ],
      ),
    );
  }
}
