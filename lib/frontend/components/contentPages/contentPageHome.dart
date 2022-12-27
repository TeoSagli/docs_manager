import 'dart:async';

import 'package:flutter/material.dart';

import '../../../backend/delete_db.dart';
import '../../../backend/read_db.dart';
import '../../../backend/update_db.dart';
import '../file_card.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ContentHome extends StatefulWidget {
  const ContentHome({super.key});

  @override
  State<ContentHome> createState() => ContentHomeState();
}

class ContentHomeState extends State<ContentHome> {
  late StreamSubscription readFileCards;
  List<Widget> fileCardsList = [constants.emptyBox];

  late StreamSubscription readCategoriesCards;
  List<Container> categoriesCardsList = [];
  List<int> itemsList = [];
  int length = 0;

  @override
  void initState() {
    setState(() {
      readFileCards = retrieveAllFilesDB(
          fulfillFileCards, moveToFile, moveToEditFile, removeFileCard);

      readCategoriesCards =
          retrieveCategoryOverviewDB(fulfillCategoriesCards, moveToCategory);
    });
    super.initState();
  }

  @override
  void deactivate() {
    readFileCards.cancel();
    readCategoriesCards.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      'Categories',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: categoriesCardsList),
                  ),
                ]),
          ),
        ),
      ]),
      const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
        child: Text(
          'Recent Files',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      Stack(children: [
        fileCardsList.isEmpty
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
                    children: fileCardsList),
              ),
      ]),
    ]);
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
  fulfillFileCards(
    List<Widget> myCards,
  ) {
    setState(() {
      fileCardsList = myCards;
    });
    /*print("Cardlist ${cardsList.toList().toString()} is here");
    print("Orderlist ${itemsList.toList().toString()} is here");*/
  }

//===================================================================================
//Fill file card
  fulfillCategoriesCards(
    List<Container> myCards,
    List<int> myOrders,
  ) {
    setState(() {
      itemsList = myOrders;
      categoriesCardsList = myCards;
    });
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
  moveToCategory(catName, context) {
    Navigator.pushNamed(
      context,
      '/categories/view/$catName',
    );
  }

  //========================================================
//Move router to Category View page
  removeFileCard(FileCard cardToDelete) {
    for (var element in fileCardsList) {
      if (element == cardToDelete) {
        deleteFileDB(cardToDelete.file.categoryName, cardToDelete.fileName);
        deleteFileStorage(cardToDelete.file.extension,
            cardToDelete.file.categoryName, cardToDelete.fileName);

        onUpdateNFiles(cardToDelete.file.categoryName);
        setState(() {
          fileCardsList.remove(element);
        });
        break;
      }
    }
  }
}
