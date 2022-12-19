import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:flutter/material.dart';

class CategoryEditPage extends StatefulWidget {
  String catName;
  CategoryEditPage({required this.catName, super.key});

  @override
  State<StatefulWidget> createState() => CategoryEditState();
}

class CategoryEditState extends State<CategoryEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyBottomBar(context, 4),
        appBar: MyAppBar('View category ${widget.catName}', true, context),
        body: Text("Editing category ${widget.catName}"));
  }
}
