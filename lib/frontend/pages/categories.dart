import 'package:docs_manager/frontend/components/contentPages/contentCategories.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_add.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<StatefulWidget> createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar("All categories", false, context),
      bottomNavigationBar: MyBottomBar(context, 2),
      body: const ContentCategories(),
      floatingActionButton: ButtonAdd(context, '/categories/create',
          Icons.add_to_photos, "Create a new category"),
    );
  }
}
