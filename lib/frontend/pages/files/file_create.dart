import 'package:flutter/material.dart';

import '../../components/app_bar.dart';
import '../../components/bottom_bar.dart';

class FileCreatePage extends StatelessWidget {
  const FileCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Upload a file", true, context),
      bottomNavigationBar: MyBottomBar(context, 4),
      body: Column(children: const [Text("Upload a file")]),
    );
  }
}
