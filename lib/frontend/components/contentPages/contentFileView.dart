import 'package:flutter/material.dart';

class ContentFileView extends StatefulWidget {
  final String fileName;
  const ContentFileView(this.fileName, {super.key});

  @override
  State<ContentFileView> createState() => ContentFileViewState();
}

class ContentFileViewState extends State<ContentFileView> {
  @override
  Widget build(BuildContext context) {
    return Text("Viewing file ${widget.fileName}");
  }
}
