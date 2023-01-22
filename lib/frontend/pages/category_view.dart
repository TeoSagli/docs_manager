import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/contentPages/content_category_view.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
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
        appBar: MyAppBar('View $catName', true, context, true, Navigator.pop,
            Navigator.pushNamed, updateUserLogutStatus),
        drawer: const MyDrawer(),
        body: ContentCategoryView(catName),
        floatingActionButton: ButtonAdd(
            context,
            '/files/create/$catName',
            Icons.post_add_rounded,
            "Create a new file in $catName",
            Navigator.pushNamed));
  }
}
