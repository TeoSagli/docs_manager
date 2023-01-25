import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_file_view.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FileViewPage extends StatelessWidget {
  final ContentFileView content;
  final MyAppBar myAppBar;
  final MyDrawer myDrawer;
  final String fileName;
  const FileViewPage(this.content, this.myAppBar, this.myDrawer,
      {required this.fileName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(hasScrollBody: false, child: content),
        ],
      ),
    );
  }
}
