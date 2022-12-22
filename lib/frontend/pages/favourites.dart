import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/contentFavourites.dart';
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
      bottomNavigationBar: MyBottomBar(context, 3),
      appBar: MyAppBar("Favourites", false, context),
      body: const ContentFavourites(),
    );
  }
}
