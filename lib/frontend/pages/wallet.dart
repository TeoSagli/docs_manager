import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Wallet", true, context),
      bottomNavigationBar: MyBottomBar(context, 1),
      body: Stack(children: const [Text('Wallet')]),
    );
  }
}
