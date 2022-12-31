import 'package:flutter/material.dart';
import 'dart:async';

import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';

import 'package:docs_manager/frontend/components/widgets/category_card.dart';

class ContentCategories extends StatefulWidget {
  const ContentCategories({super.key});

  @override
  State<ContentCategories> createState() => ContentCategoriesState();
}

class ContentCategoriesState extends State<ContentCategories> {
  List<Container> cardsList = [];
  List<int> itemsList = [];
  int length = 0;
  late StreamSubscription listenCards;

  @override
  void initState() {
    setState(() {
      listenCards = retrieveCategoriesDB(
          fulfillCard, moveToCategory, moveToEditCategory, removeCard);
    });

    super.initState();
  }

  @override
  void deactivate() {
    listenCards.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final Container card = cardsList.removeAt(oldIndex);
        final int item = itemsList.removeAt(oldIndex);
        setState(() {
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
      listenCards.cancel();
    });
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
