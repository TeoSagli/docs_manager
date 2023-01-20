import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_file_create.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FileCreatePage extends StatelessWidget {
  final String catSelected;
  const FileCreatePage({required this.catSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar("File creation", true, context),
        drawer: const MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ContentFileCreate(catSelected),
            )
          ],
        ));
  }
}
