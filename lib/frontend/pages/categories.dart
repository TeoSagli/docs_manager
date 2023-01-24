import 'package:docs_manager/frontend/components/contentPages/content_categories.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/button_add.dart';

class CategoriesPage extends StatelessWidget {
  final ContentCategories content;
  final MyAppBar myAppBar;
  final MyBottomBar myBottomBar;
  final MyDrawer myDrawer;
  const CategoriesPage(
      this.content, this.myAppBar, this.myBottomBar, this.myDrawer,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar,
      bottomNavigationBar: myBottomBar,
      drawer: myDrawer,
      body: content,
      floatingActionButton: ButtonAdd(context, '/categories/create',
          Icons.add_to_photos, "Create a new category", Navigator.pushNamed),
    );
  }
}
