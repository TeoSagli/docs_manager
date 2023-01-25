import 'package:docs_manager/frontend/components/contentPages/content_category_view.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/widgets/button_add.dart';
import '../components/widgets/app_bar.dart';

class CategoryViewPage extends StatelessWidget {
  final String catName;
  final ContentCategoryView content;
  final MyAppBar myAppBar;
  final MyDrawer myDrawer;
  const CategoryViewPage(this.content, this.myAppBar, this.myDrawer,
      {required this.catName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar,
      drawer: myDrawer,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: content,
          ),
        ],
      ),
      floatingActionButton: ButtonAdd(
          context,
          '/files/create/$catName',
          Icons.post_add_rounded,
          "Create a new file in $catName",
          Navigator.pushNamed),
    );
  }
}
