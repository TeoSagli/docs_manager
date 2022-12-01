import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class ExpirationsPage extends StatelessWidget {
  const ExpirationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Expirations", true, context),
      bottomNavigationBar: MyBottomBar(context, 1),
      body: Stack(children: const [Text('Expirations')]),
    );
  }
}
