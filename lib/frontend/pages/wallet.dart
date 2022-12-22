import 'package:docs_manager/frontend/components/contentPages/contentWallet.dart';
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar("Wallet", false, context),
        bottomNavigationBar: MyBottomBar(context, 1),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: const ContentWallet(),
          ),
        ));
  }
}
