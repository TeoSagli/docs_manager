import 'package:flutter/material.dart';

class ContentCategoryEdit extends StatefulWidget {
  String catName;
  ContentCategoryEdit(this.catName, {super.key});

  @override
  State<ContentCategoryEdit> createState() => ContentCategoryEditState();
}

class ContentCategoryEditState extends State<ContentCategoryEdit> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Editing category ${widget.catName}"));
  }
}
