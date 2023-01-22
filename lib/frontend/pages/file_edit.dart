import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_file_edit.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FileEditPage extends StatelessWidget {
  String fileName;
  FileEditPage({required this.fileName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar('Edit file $fileName', true, context, true),
        drawer: const MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false, child: ContentFileEdit(fileName))
          ],
        ));
  }
}
