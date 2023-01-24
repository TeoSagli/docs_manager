import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_favourites.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  final ContentFavourites content;
  final MyAppBar myAppBar;
  final MyBottomBar myBottomBar;
  final MyDrawer myDrawer;
  const FavouritesPage(
      this.content, this.myAppBar, this.myBottomBar, this.myDrawer,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: myBottomBar,
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
