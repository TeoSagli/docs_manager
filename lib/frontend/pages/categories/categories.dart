import 'package:docs_manager/backend/category_read_db.dart';
import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_add.dart';
import 'package:docs_manager/frontend/components/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<StatefulWidget> createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  List<CategoryCard> cardsList = [];

  @override
  void initState() {
    listCategoryStorage(fullfillCard);
    setState(() {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("All categories", true, context),
      bottomNavigationBar: MyBottomBar(context, 2),
      body: Stack(children: [
        ListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: cardsList.isEmpty ? [] : cardsList,
        ),
        ButtonAdd(context, '/categories/create')
      ]),
    );
  }

//========================================================
//Fill category card
  fullfillCard(String catName, Category c) {
    setState(() {
      cardsList.add(
          CategoryCard(catName, c, '3 upcoming due dates', 0, moveToCategory));
    });
  }

//========================================================
//Move router to Category View page
  moveToCategory(id, context) {
    Navigator.pushNamed(
      context,
      '/categories/view/$id',
    );
  }
//========================================================
}
