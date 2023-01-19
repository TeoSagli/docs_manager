import 'package:docs_manager/frontend/components/contentPages/content_wallet.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import '../components/widgets/app_bar.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar('Wallet', false, context),
      bottomNavigationBar: MyBottomBar(context, 1),
      body: const CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ContentWallet(),
          )
        ],
      ),
    );
  }
}
