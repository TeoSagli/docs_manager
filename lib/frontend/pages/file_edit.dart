import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:flutter/material.dart';

class FileEditPage extends StatefulWidget {
  String fileName;
  FileEditPage({required this.fileName, super.key});

  @override
  State<StatefulWidget> createState() => FileEditPageState();
}

class FileEditPageState extends State<FileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyBottomBar(context, 4),
        appBar: MyAppBar('Edit file ${widget.fileName}', true, context),
        body: Text("Editing file ${widget.fileName}"));
  }
}
