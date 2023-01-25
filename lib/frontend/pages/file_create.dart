import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_file_create.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FileCreatePage extends StatelessWidget {
  final String catSelected;
  final ContentFileCreate content;
  final MyAppBar myAppBar;
  final MyDrawer myDrawer;
  const FileCreatePage(
      this.content, this.myAppBar, this.myDrawer, this.catSelected,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
