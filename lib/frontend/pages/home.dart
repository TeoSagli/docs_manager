import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/button_add.dart';
import 'package:docs_manager/frontend/components/contentPages/contentPageHome.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar('Homepage', false, context),
      bottomNavigationBar: MyBottomBar(context, 0),
      body: const CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ContentHome(),
          ),
        ],
      ),
      floatingActionButton: ButtonAdd(context, '/files/create',
          Icons.post_add_rounded, "Create a new file"),
    );
  }
}
