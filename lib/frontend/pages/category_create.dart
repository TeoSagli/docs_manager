import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_category_create.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  CategoryCreateWidgetState createState() => CategoryCreateWidgetState();
}

class CategoryCreateWidgetState extends State<CategoryCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar('Category creation', true, context, true),
        drawer: const MyDrawer(),
        body: const CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ContentCategoryCreate(),
            )
          ],
        ));
  }
}
