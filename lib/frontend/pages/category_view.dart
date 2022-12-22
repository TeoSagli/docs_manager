import 'package:docs_manager/frontend/components/contentPages/contentCategoryView.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/button_add.dart';
import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class CategoryViewPage extends StatelessWidget {
  final String catName;
  const CategoryViewPage({required this.catName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyBottomBar(context, 4),
        appBar: MyAppBar('View $catName', true, context),
        body: Stack(
          children: [
            ContentCategoryView(catName),
            ButtonAdd(context, '/files/create/$catName', Icons.post_add_rounded,
                "Create a new file in $catName"),
          ],
        ));
  }
}
