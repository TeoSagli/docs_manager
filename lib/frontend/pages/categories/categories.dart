import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/button_add.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../components/bottom_bar.dart';
import '../../components/category_card.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<StatefulWidget> createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  List<Widget> cardsList = [];

  //  loading wheel

  /* SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    )*/

  @override
  void initState() {
    cardsList.clear();
    print("InitState called");
    final dbRef = FirebaseDatabase.instance.ref("categories");
    dbRef.get().asStream().forEach((element) {
      for (var el in element.children) {
        //el.value contenuto di category{path:..., nfiles:...}
        final data =
            Map<String, dynamic>.from(el.value as Map<String, dynamic>);
        //el.key nome di category
        fullfillCard(el.key.toString(), Category.fromRTDB(data));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Build called" + cardsList.toString());
    return Scaffold(
      appBar: MyAppBar("All categories", true, context),
      bottomNavigationBar: MyBottomBar(context, 2),
      body: Stack(children: [
        ListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: cardsList,
        ),
        ButtonAdd(context, '/categories/create')
      ]),
    );
  }

  fullfillCard(String catName, Category c) {
    setState(() {
      cardsList.add(
          CategoryCard(catName, c, '3 upcoming due dates', 0, moveToCategory));
    });
  }

  moveToCategory(id, context) {
    Navigator.pushNamed(
      context,
      '/categories/view/$id',
    );
  }

  initCards() {}
}
