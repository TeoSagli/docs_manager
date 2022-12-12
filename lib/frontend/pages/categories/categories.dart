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
  List<Widget> cardsList = [];
  final List<int> items = [];

  @override
  void initState() {
    listCategoryStorage(fullfillCard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("All categories", true, context),
      bottomNavigationBar: MyBottomBar(context, 2),
      body: Stack(children: [
        ReorderableListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final int item = items.removeAt(oldIndex);
              items.insert(newIndex, item);
              print("Items:$items");
            });
          },
          children: cardsList.isEmpty ? [] : cardsList,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonAdd(context, '/categories/edit', Icons.edit),
            ButtonAdd(context, '/categories/create', Icons.add)
          ],
        )
      ]),
    );
  }

//========================================================
//Fill category card
  fullfillCard(String catName, int index, Category c) {
    setState(() {
      items.add(index);
      cardsList.add(Container(
        key: Key(index.toString()),
        child:
            CategoryCard(catName, c, '3 upcoming due dates', 0, moveToCategory),
      ));
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
