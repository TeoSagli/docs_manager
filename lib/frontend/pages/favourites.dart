import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_favourites.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<StatefulWidget> createState() => FavouriteViewPageState();
}

class FavouriteViewPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: MyBottomBar(context, 3),
        appBar: MyAppBar("Favourites", false, context, true),
        drawer: const MyDrawer(),
        body: const CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ContentFavourites(),
            ),
          ],
        ));
  }
}
