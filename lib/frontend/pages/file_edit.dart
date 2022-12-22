import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/contentFileEdit.dart';
import 'package:flutter/material.dart';

class FileEditPage extends StatelessWidget {
  String fileName;
  FileEditPage({required this.fileName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyBottomBar(context, 4),
        appBar: MyAppBar('Edit file $fileName', true, context),
        body: ContentFileEdit(fileName));
  }
}
