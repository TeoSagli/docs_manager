import 'package:docs_manager/frontend/components/widgets/buttons_view_mode.dart';
import 'package:docs_manager/frontend/components/widgets/title_text_v2.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:docs_manager/others/constants.dart' as constants;

class ContentFavourites extends StatefulWidget {
  final dynamic retrieveAllFilesDB;
  final dynamic deleteFileDB;
  final dynamic deleteFileStorage;
  final dynamic onUpdateNFilesDB;
  final dynamic navigateTo;
  const ContentFavourites(this.retrieveAllFilesDB, this.deleteFileDB,
      this.deleteFileStorage, this.onUpdateNFilesDB, this.navigateTo,
      {super.key});

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
    if (mounted) {
      setState(() {
        //readCards = retrieveFilesDB();
        readCards = widget.retrieveAllFilesDB(
            fulfillCard, moveToFile, moveToEditFile, removeFileCard, true);
      });
      super.initState();
    }
  }

  @override
  void dispose() {
    readCards.cancel();
    super.dispose();
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
                const TitleText2("Your favourite docs will be here"),
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
    if (mounted) {
      setState(() {
        currMode = modeToSet;
      });
    }
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
    widget.navigateTo(
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
    if (mounted) {
      setState(() {
        fileCardsGrid = myCardsGrid;
        fileCardsList = myCardsList;
      });
    }
  }

//===================================================================================
//Move router to Category View page
  moveToEditFile(fileName, context) {
    widget.navigateTo(
      context,
      '/files/edit/$fileName',
    );
  }

//========================================================
//Move router to Category View page
  removeFileCard(cardToDelete) {
    widget.deleteFileDB(cardToDelete.file.categoryName, cardToDelete.fileName);
    widget.deleteFileStorage(cardToDelete.file.extension,
        cardToDelete.file.categoryName, cardToDelete.fileName);

    widget.onUpdateNFilesDB(cardToDelete.file.categoryName);
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
}
