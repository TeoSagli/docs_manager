import 'dart:async';

import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/button_add.dart';
import 'package:docs_manager/frontend/components/file_card.dart';
import 'package:flutter/material.dart';

import 'package:docs_manager/others/constants.dart' as constants;

import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class CategoryViewPage extends StatefulWidget {
  final String catName;
  const CategoryViewPage({required this.catName, super.key});

  @override
  State<StatefulWidget> createState() => CategoryViewPageState();
}

class CategoryViewPageState extends State<CategoryViewPage> {
  late StreamSubscription readCards;
  List<Widget> cardsList = [constants.emptyBox];
//===================================================================================
// Activate listeners
  @override
  void initState() {
    setState(() {
      readCards = retrieveFilesDB(
          widget.catName, fulfillCard, moveToFile, moveToEditFile, removeCard);
    });
    super.initState();
  }

  @override
  void deactivate() {
    readCards.cancel();
    super.deactivate();
  }
/*
  @override
  void didUpdateWidget(CategoryViewPage c) {
    setState(() {
      readCards.cancel();
      readCards = retrieveFilesDB(
          widget.catName, fulfillCard, moveToFile, moveToEditFile, removeCard);
    });
    super.didUpdateWidget(c);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomBar(context, 4),
      appBar: MyAppBar('View ${widget.catName}', true, context),
      body: Stack(
        children: [
          cardsList.isEmpty
              ? constants.emptyPage
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                      spacing: 8,
                      runSpacing: 12,
                      alignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      children: cardsList),
                ),
          ButtonAdd(context, '/files/create/${widget.catName}',
              Icons.post_add_rounded, "Create a new file in ${widget.catName}"),
        ],
      ),
    );
  }

//===================================================================================
// Move to file page
  moveToFile(fileName, context) {
    Navigator.pushNamed(
      context,
      '/files/view/$fileName',
    );
  }

//========================================================
//Fill file card
  fulfillCard(
    List<Widget> myCards,
  ) {
    setState(() {
      cardsList = myCards;
    });
    /*print("Cardlist ${cardsList.toList().toString()} is here");
    print("Orderlist ${itemsList.toList().toString()} is here");*/
  }

//===================================================================================
//Move router to Category View page
  moveToEditFile(fileName, context) {
    Navigator.pushNamed(
      context,
      '/files/edit/$fileName',
    );
  }

  //========================================================
//Move router to Category View page
  removeCard(FileCard cardToDelete) {
    int i = 0;
    for (var element in cardsList) {
      if (element == cardToDelete) {
        deleteFileDB(cardToDelete.file.categoryName, cardToDelete.fileName);
        deleteFileStorage(cardToDelete.file.path[0] as String,
            cardToDelete.file.categoryName);

        onUpdateNFiles(cardToDelete.file.categoryName);
        setState(() {
          cardsList.remove(element);
        });
        break;
      }
      i++;
    }
  }
  //========================================================
}
