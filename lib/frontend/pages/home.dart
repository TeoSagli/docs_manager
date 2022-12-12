import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/button_add.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Homepage", false, context),
      bottomNavigationBar: MyBottomBar(context, 0),
      body: Stack(children: [
        const Text("Home"),
        ButtonAdd(context, '/files/create', Icons.add),
      ]),
    );
  }
}
