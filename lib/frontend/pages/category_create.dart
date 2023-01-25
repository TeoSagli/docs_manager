import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_category_create.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CategoryCreatePage extends StatelessWidget {
  final ContentCategoryCreate content;
  final MyAppBar myAppBar;
  final MyDrawer myDrawer;
  const CategoryCreatePage(this.content, this.myAppBar, this.myDrawer,
      {super.key});

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
    );
  }
}
