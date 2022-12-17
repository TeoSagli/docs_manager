import 'dart:async';

import 'package:docs_manager/backend/category_read_db.dart';
import 'package:docs_manager/backend/category_update_db.dart';
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
  List<Container> cardsList = [];
  List<int> itemsList = [];
  int length = 0;
  late StreamSubscription readCards;
//===================================================================================
// Activate listeners
  @override
  void initState() {
    readCards = retrieveCategoryDB(fullfilCard, moveToCategory);
    super.initState();
  }

//===================================================================================
// Deactivate listeners
  @override
  void deactivate() {
    readCards.cancel();
    super.deactivate();
  }

//===================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("All categories", false, context),
      bottomNavigationBar: MyBottomBar(context, 2),
      body: Stack(children: [
        ReorderableListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            setState(() {
              final Container card = cardsList.removeAt(oldIndex);
              final int item = itemsList.removeAt(oldIndex);
              itemsList.insert(newIndex, item);
              cardsList.insert(newIndex, card);
            });
            for (int element in itemsList) {
              updateOrderDB(
                  element,
                  (cardsList.elementAt(element).child! as CategoryCard)
                      .categoryName);
            }

            //   print("Items refreshing: $itemsList");
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
  fullfilCard(
    List<Container> myCards,
    List<int> myOrders,
  ) {
    setState(() {
      itemsList = myOrders;
      cardsList = myCards;
    });
    /*print("Cardlist ${cardsList.toList().toString()} is here");
    print("Orderlist ${itemsList.toList().toString()} is here");*/
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
