import 'dart:async';

import 'package:flutter/material.dart';

import '../../backend/delete_db.dart';
import '../../backend/read_db.dart';
import '../../backend/update_db.dart';
import '../components/app_bar.dart';
import '../components/bottom_bar.dart';
import '../components/file_card.dart';

import 'package:docs_manager/others/constants.dart' as constants;

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<StatefulWidget> createState() => FavouriteViewPageState();
}

class FavouriteViewPageState extends State<FavouritesPage> {
  late StreamSubscription readCards;
  List<Widget> cardsList = [];
//===================================================================================
// Activate listeners
  @override
  void initState() {
    setState(() {
      //readCards = retrieveFilesDB();
      readCards = retrieveAllFavouriteFilesDB(
          fulfillCard, moveToFile, moveToEditFile, removeCard);
    });
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
      bottomNavigationBar: MyBottomBar(context, 3),
      appBar: MyAppBar("Favourites", false, context),
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
        ],
      ),
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
        deleteFileStorage(cardToDelete.file.path[0] as String,
            cardToDelete.file.categoryName);
        onUpdateNFiles(cardToDelete.file.categoryName);
        setState(() {
          cardsList.remove(element);
        });
        break;
      }
    }
  }
}
