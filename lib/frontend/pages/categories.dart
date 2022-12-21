import 'dart:async';

import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
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
  late StreamSubscription listenCards;

//===================================================================================
// Activate listeners
  @override
  void initState() {
    setState(() {
      listenCards = retrieveCategoryDB(
          fulfillCard, moveToCategory, moveToEditCategory, removeCard);
      // listenCards.pause();
    });

    super.initState();
  }

//===================================================================================
// Deactivate listeners
  @override
  void deactivate() {
    listenCards.cancel();
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
        ButtonAdd(context, '/categories/create', Icons.add_to_photos,
            "Create a new category")
      ]),
    );
  }

//========================================================
//Fill category card
  fulfillCard(
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
  moveToCategory(catName, context) {
    Navigator.pushNamed(
      context,
      '/categories/view/$catName',
    );
  }

//========================================================
//Move router to Category View page
  moveToEditCategory(catName, context) {
    Navigator.pushNamed(
      context,
      '/categories/edit/$catName',
    );
  }

  //========================================================
//Move router to Category View page
  removeCard(CategoryCard cardToDelete) {
    int i = 0;
    for (var element in cardsList) {
      if (element.child == cardToDelete) {
        deleteCategoryDB(cardToDelete.categoryName);
        deleteCategoryStorage(
            cardToDelete.category.path, cardToDelete.categoryName);
        for (int j = 0; j < itemsList.length; j++) {
          if (itemsList.elementAt(i) < itemsList[j]) {
            itemsList[j]--;
            updateOrderDB(itemsList[j],
                (cardsList.elementAt(j).child as CategoryCard).categoryName);
          }
        }
        setState(() {
          cardsList.remove(element);
          itemsList.removeAt(i);
        });
        break;
      }
      i++;
    }
  }
  //========================================================
}
