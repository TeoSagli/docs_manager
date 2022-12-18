import 'dart:async';

import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class FileViewPage extends StatefulWidget {
  final String fileName;
  const FileViewPage({required this.fileName, super.key});

  @override
  State<StatefulWidget> createState() => FileViewPageState();
}

class FileViewPageState extends State<FileViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomBar(context, 4),
      appBar: MyAppBar('View file ${widget.fileName}', true, context),
      body: Text(widget.fileName),
    );
  }
}
