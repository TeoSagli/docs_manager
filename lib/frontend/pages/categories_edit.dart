import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/contentCategoryEdit.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class CategoryEditPage extends StatelessWidget {
  String catName;
  CategoryEditPage({required this.catName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: MyBottomBar(context, 4),
        appBar: MyAppBar('View category $catName', true, context),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ContentCategoryEdit(catName),
            )
          ],
        ));
  }
}
