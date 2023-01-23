import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_file_view.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';

class FileViewPage extends StatelessWidget {
  final String fileName;
  const FileViewPage({required this.fileName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar('View file $fileName', true, context, true,
            Navigator.pop, Navigator.pushNamed, updateUserLogutStatus),
        drawer: const MyDrawer(onAccountStatus, onSettings),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false, child: ContentFileView(fileName))
          ],
        ));
  }
}
