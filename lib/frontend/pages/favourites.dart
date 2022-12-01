import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Favourites", true, context),
      bottomNavigationBar: MyBottomBar(context, 3),
      body: Column(children: const [Text("Favourites")]),
    );
  }
}
