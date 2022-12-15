import 'package:docs_manager/backend/category_read_db.dart';
import 'package:docs_manager/backend/category_update_db.dart';
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
  List<int> itemsList = [];
  int length = 0;

  @override
  void initState() {
    // retrieveCardsLength(setLength);

    print("OOOOOO$length");
    retrieveCategoryDB(fullfillCard);
    cardsList.sort((a, b) {
      //a.key.toString().compareTo(b.key.toString());
      print("${a.key.toString()}+${b.key.toString()}");
      return 0;
    });
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
              setState(() {
                final int item = itemsList.removeAt(oldIndex);
                itemsList.insert(newIndex, item);
              });

              updateOrderDB(itemsList);
              print("Items:$itemsList");
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
  fullfillCard(String catName, Category cat) {
    int count = 0;
    setState(() {
      itemsList.add(cat.order);
      cardsList.add(Container(
        key: Key(cat.order.toString()),
        child: CategoryCard(catName, cat, moveToCategory),
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

  setLength(int l) {
    setState(() {
      length = l;
    });
  }
}
