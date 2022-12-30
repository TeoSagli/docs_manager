import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/file_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:docs_manager/others/constants.dart' as constants;

class ContentFavourites extends StatefulWidget {
  const ContentFavourites({super.key});

  @override
  State<ContentFavourites> createState() => ContentFavouritesState();
}

class ContentFavouritesState extends State<ContentFavourites> {
  late StreamSubscription readCards;
  List<Widget> cardsList = [];

  @override
  void initState() {
    setState(() {
      //readCards = retrieveFilesDB();
      readCards = retrieveAllFilesDB(
          fulfillCard, moveToFile, moveToEditFile, removeCard, true);
    });
    super.initState();
  }

  @override
  void deactivate() {
    readCards.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
      ],
    );
  }

//===================================================================================
// Move to file page
  moveToFile(id, context) {
    Navigator.pushNamed(
      context,
      '/files/view/$id',
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
    for (var element in cardsList) {
      if (element == cardToDelete) {
        deleteFileDB(cardToDelete.file.categoryName, cardToDelete.fileName);
        deleteFileStorage(cardToDelete.file.extension,
            cardToDelete.file.categoryName, cardToDelete.fileName);
        onUpdateNFilesDB(cardToDelete.file.categoryName);
        setState(() {
          cardsList.remove(element);
        });
        break;
      }
    }
  }
}
