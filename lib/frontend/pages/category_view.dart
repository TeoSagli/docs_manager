import 'package:docs_manager/frontend/components/contentPages/contentCategoryView.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/widgets/button_add.dart';
import '../components/widgets/app_bar.dart';

class CategoryViewPage extends StatelessWidget {
  final String catName;
  const CategoryViewPage({required this.catName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: MyBottomBar(context, 4),
        appBar: MyAppBar('View $catName', true, context),
        body: ContentCategoryView(catName),
        floatingActionButton: ButtonAdd(context, '/files/create/$catName',
            Icons.post_add_rounded, "Create a new file in $catName"));
  }
}
