import 'package:docs_manager/frontend/components/widgets/buttons_view_mode.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'dart:async';

import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';

class ContentCategoryView extends StatefulWidget {
  final String catName;
  final ReadDB readDB;
  final UpdateDB updateDB;
  final DeleteDB deleteDB;
  final Alert alert;
  const ContentCategoryView(
      this.catName, this.readDB, this.deleteDB, this.updateDB, this.alert,
      {super.key});

  @override
  State<StatefulWidget> createState() => ContentCategoryViewState();
}

class ContentCategoryViewState extends State<ContentCategoryView> {
  List<Widget> fileCardsGrid = [constants.emptyBox];
  List<Widget> fileCardsList = [constants.emptyBox];
  int currMode = 0;

  @override
  void initState() {
    setState(() {
      widget.readDB.retrieveFilesFromCategoryDB(widget.catName, fulfillCard,
          moveToFile, moveToEditFile, removeFileCard, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fileCardsGrid.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/${widget.catName}.png',
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.6),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "No documents yet!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              ViewMode(changeViewMode, currMode),
              Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  alignment: WrapAlignment.spaceEvenly,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: changeCardsView(currMode)),
            ]),
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
  moveToFile(fileName, context) {
    widget.alert.navigateTo(
      '/files/view/$fileName',
      context,
    );
  }

//========================================================
//Fill file card
  fulfillCard(
    List<Widget> myCards,
    List<Widget> myCardsList,
  ) {
    setState(() {
      fileCardsGrid = myCards;
      fileCardsList = myCardsList;
    });
    /*print("Cardlist ${cardsList.toList().toString()} is here");
    print("Orderlist ${itemsList.toList().toString()} is here");*/
  }

//===================================================================================
//Move router to Category View page
  moveToEditFile(fileName, context) {
    widget.alert.navigateTo(
      '/files/edit/$fileName',
      context,
    );
  }

  //========================================================
//Move router to Category View page
  removeFileCard(cardToDelete) {
    widget.deleteDB
        .deleteFileDB(cardToDelete.file.categoryName, cardToDelete.fileName);
    widget.deleteDB.deleteFileStorage(cardToDelete.file.extension,
        cardToDelete.file.categoryName, cardToDelete.fileName);

    widget.updateDB.onUpdateNFilesDB(cardToDelete.file.categoryName);
    switch (currMode) {
      case 0:
        setState(() {
          fileCardsList.removeAt(fileCardsGrid.indexOf(cardToDelete));
          fileCardsGrid.remove(cardToDelete);
        });
        break;
      case 1:
        setState(() {
          fileCardsGrid.removeAt(fileCardsList.indexOf(cardToDelete));
          fileCardsList.remove(cardToDelete);
        });
        break;
    }
  }

  //========================================================
}
