import 'package:docs_manager/frontend/components/contentPages/content_wallet.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../components/widgets/app_bar.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar('Wallet', false, context, true),
      bottomNavigationBar: MyBottomBar(context, 1),
      drawer: const MyDrawer(),
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
