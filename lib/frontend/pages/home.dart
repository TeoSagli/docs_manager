import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_add.dart';
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
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(children: [
                  const ContentHome(),
                  ButtonAdd(context, '/files/create', Icons.post_add_rounded,
                      "Create a new file"),
                ]))
          ],
        ));
  }
}
