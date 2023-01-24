import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/button_add.dart';
import 'package:docs_manager/frontend/components/contentPages/content_home.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ContentHome content;
  final MyAppBar myAppBar;
  final MyBottomBar myBottomBar;
  final MyDrawer myDrawer;
  const HomePage(this.content, this.myAppBar, this.myBottomBar, this.myDrawer,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar,
      bottomNavigationBar: myBottomBar,
      drawer: myDrawer,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: content,
          ),
        ],
      ),
      floatingActionButton: ButtonAdd(context, '/files/create',
          Icons.post_add_rounded, "Create a new file", Navigator.pushNamed),
    );
  }
}
