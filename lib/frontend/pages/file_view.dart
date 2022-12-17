import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class FileViewPage extends StatelessWidget {
  final String id;
  const FileViewPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomBar(context, 4),
      appBar: MyAppBar('View file $id', true, context),
      body: Text(id),
    );
  }
}
