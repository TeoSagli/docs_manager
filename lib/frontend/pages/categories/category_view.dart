import 'package:flutter/material.dart';

import '../../components/app_bar.dart';
import '../../components/bottom_bar.dart';

class CategoryViewPage extends StatelessWidget {
  final String id;
  const CategoryViewPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomBar(context, 4),
      appBar: MyAppBar('View category', true, context),
      body: Text("View category $id"),
    );
  }
}
