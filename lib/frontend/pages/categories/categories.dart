import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/button_add.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_bar.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("All categories", true, context),
      bottomNavigationBar: MyBottomBar(context, 2),
      body: Stack(children: [ButtonAdd(context, '/categories/create')]),
    );
  }
}
