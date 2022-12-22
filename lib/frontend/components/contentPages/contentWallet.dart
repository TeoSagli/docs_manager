import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/wallet_card.dart';

class ContentWallet extends StatefulWidget {
  const ContentWallet({super.key});

  @override
  State<ContentWallet> createState() => ContentWalletState();
}

class ContentWalletState extends State<ContentWallet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F4F8),
          ),
        ),
        WalletCard('Tesla Model Y', 'Car', '1969-07-20',
            'assets/images/test.png', Icons.fitness_center, 0, moveToFile),
        WalletCard('The Running Ragamuffins', 'Fitness', '2001-09-20',
            'assets/images/test.png', Icons.fitness_center, 1, moveToFile)
      ],
    );
  }

  moveToFile(id, context) {
    Navigator.pushNamed(
      context,
      '/files/view/$id',
    );
  }
}
