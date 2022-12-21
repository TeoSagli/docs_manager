import 'package:docs_manager/frontend/components/wallet_card.dart';
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                ),
                WalletCard(
                    'Tesla Model Y',
                    'Car',
                    '1969-07-20',
                    'assets/images/test.png',
                    Icons.fitness_center,
                    0,
                    moveToFile),
                WalletCard(
                    'The Running Ragamuffins',
                    'Fitness',
                    '2001-09-20',
                    'assets/images/test.png',
                    Icons.fitness_center,
                    1,
                    moveToFile)
              ],
            ),
          ),
        ));
  }

  moveToFile(id, context) {
    Navigator.pushNamed(
      context,
      '/files/view/$id',
    );
  }
}
