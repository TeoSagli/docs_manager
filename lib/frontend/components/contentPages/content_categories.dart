import 'dart:async';

import 'package:docs_manager/frontend/components/widgets/title_text_v2.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/widgets/category_card.dart';

class ContentCategories extends StatefulWidget {
  final dynamic retrieveCategoriesDB;
  final dynamic updateOrderDB;
  final dynamic deleteCategoryDB;
  final dynamic deleteCategoryStorage;
  final dynamic navigateTo;
  const ContentCategories(this.retrieveCategoriesDB, this.updateOrderDB,
      this.deleteCategoryDB, this.deleteCategoryStorage, this.navigateTo,
      {super.key});

  @override
  State<ContentCategories> createState() => ContentCategoriesState();
}

class ContentCategoriesState extends State<ContentCategories> {
  List<Container> cardsList = [];
  List<int> itemsList = [];
  int length = 0;
  late StreamSubscription readCats;

  @override
  void initState() {
    setState(() {
      readCats = widget.retrieveCategoriesDB(
          fulfillCard, moveToCategory, moveToEditCategory, removeCard);
    });

    super.initState();
  }

  @override
  void dispose() {
    readCats.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleText2("Group here your documents"),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: ReorderableListView(
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
                widget.updateOrderDB(
                    element,
                    (cardsList.elementAt(element).child! as CategoryCard)
                        .categoryName);
              }

              //   print("Items refreshing: $itemsList");
            },
            children: cardsList.isEmpty ? [] : cardsList,
          ),
        ),
      ],
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
      readCats.cancel();
    });
  }

//========================================================
//Move router to Category View page
  moveToCategory(catName, context) {
    widget.navigateTo(
      context,
      '/categories/view/$catName',
    );
  }

//========================================================
//Move router to Category View page
  moveToEditCategory(catName, context) {
    widget.navigateTo(
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
        widget.deleteCategoryDB(cardToDelete.categoryName);
        widget.deleteCategoryStorage(
            cardToDelete.category.path, cardToDelete.categoryName);
        for (int j = 0; j < itemsList.length; j++) {
          if (itemsList.elementAt(i) < itemsList[j]) {
            itemsList[j]--;
            widget.updateOrderDB(itemsList[j],
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
