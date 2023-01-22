import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/contentPages/content_categories.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/button_add.dart';

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
      appBar: MyAppBar("Categories", false, context, true, Navigator.pop,
          Navigator.pushNamed, updateUserLogutStatus),
      bottomNavigationBar: MyBottomBar(context, 2, Navigator.pushNamed),
      drawer: const MyDrawer(),
      body: const ContentCategories(),
      floatingActionButton: ButtonAdd(context, '/categories/create',
          Icons.add_to_photos, "Create a new category", Navigator.pushNamed),
    );
  }
}
