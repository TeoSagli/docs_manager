import 'package:flutter/material.dart';

class ContentFileEdit extends StatefulWidget {
  final String fileName;
  const ContentFileEdit(this.fileName, {super.key});

  @override
  State<ContentFileEdit> createState() => ContentFileEditState();
}

class ContentFileEditState extends State<ContentFileEdit> {
  @override
  Widget build(BuildContext context) {
    return Text("Editing file ${widget.fileName}");
  }
}
