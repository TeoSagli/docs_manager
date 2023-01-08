import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_view_mode.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';
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
  List<Widget> fileCardsGrid = [constants.emptyBox];
  List<Widget> fileCardsList = [constants.emptyBox];
  int currMode = 0;
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
    return fileCardsGrid.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/No_fav.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Text(
                  "No documents yet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ViewMode(changeViewMode, currMode),
                Wrap(
                  spacing: 8,
                  runSpacing: 3,
                  alignment: WrapAlignment.spaceEvenly,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: changeCardsView(currMode),
                )
              ],
            ),
          );
  }

  //===================================================================================
  /// Grid view visualization to [modeToSet]
  changeViewMode(int modeToSet) {
    setState(() {
      currMode = modeToSet;
    });
  }

  //===================================================================================
  /// Change cards data structure
  List<Widget> changeCardsView(int modeToSet) {
    switch (modeToSet) {
      case 0:
        return fileCardsGrid;
      case 1:
        return fileCardsList;
      default:
        return fileCardsGrid;
    }
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
    List<Widget> myCardsGrid,
    List<Widget> myCardsList,
  ) {
    setState(() {
      fileCardsGrid = myCardsGrid;
      fileCardsList = myCardsList;
      readCards.cancel();
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
  removeCard(FileCard cardToDelete) {
    for (var element in fileCardsGrid) {
      if (element == cardToDelete) {
        deleteFileDB(cardToDelete.file.categoryName, cardToDelete.fileName);
        deleteFileStorage(cardToDelete.file.extension,
            cardToDelete.file.categoryName, cardToDelete.fileName);
        onUpdateNFilesDB(cardToDelete.file.categoryName);
        setState(() {
          fileCardsGrid.remove(element);
          fileCardsList.removeAt(fileCardsGrid.indexOf(element));
        });
        break;
      }
    }
  }
}
