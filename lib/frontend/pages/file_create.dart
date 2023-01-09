import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/contentFileCreate.dart';
import 'package:flutter/material.dart';

class FileCreatePage extends StatelessWidget {
  final String catSelected;
  const FileCreatePage({required this.catSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar("File creation", true, context),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ContentFileCreate(catSelected),
            )
          ],
        ));
  }
}
