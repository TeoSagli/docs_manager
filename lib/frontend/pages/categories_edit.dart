import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_category_edit.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';

class CategoryEditPage extends StatelessWidget {
  String catName;
  CategoryEditPage({required this.catName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar('View category $catName', true, context, true,
            Navigator.pop, Navigator.pushNamed, updateUserLogutStatus),
        drawer: const MyDrawer(onAccountStatus, onSettings),
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
