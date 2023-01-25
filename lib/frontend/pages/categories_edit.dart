import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_category_edit.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CategoryEditPage extends StatelessWidget {
  final String catName;
  final ContentCategoryEdit content;
  final MyAppBar myAppBar;
  final MyDrawer myDrawer;
  const CategoryEditPage(this.content, this.myAppBar, this.myDrawer,
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
          )
        ],
      ),
    );
  }
}
