import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
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
  bool isGridView = true;
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
        fileCardsGrid.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/No_fav.png',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Text(
                      "No favourites yet!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "View mode:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      IconButton(
                        splashRadius: 20.0,
                        iconSize: 30,
                        onPressed: () => changeViewMode1(),
                        icon: const Icon(Icons.grid_view_rounded),
                        color: isGridView
                            ? constants.mainBackColor
                            : constants.mainBackColor.withOpacity(0.5),
                      ),
                      IconButton(
                        splashRadius: 20.0,
                        iconSize: 30,
                        onPressed: () => changeViewMode2(),
                        icon: const Icon(Icons.view_list_rounded),
                        color: isGridView
                            ? constants.mainBackColor.withOpacity(0.5)
                            : constants.mainBackColor,
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                        spacing: 8,
                        runSpacing: 12,
                        alignment: WrapAlignment.spaceEvenly,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        children: isGridView ? fileCardsGrid : fileCardsList),
                  ),
                ],
              )
      ],
    );
  }

  //===================================================================================
// Grid view visualization 1
  changeViewMode1() {
    setState(() {
      isGridView = true;
    });
  }

  //===================================================================================
// Grid view visualization 2
  changeViewMode2() {
    setState(() {
      isGridView = false;
    });
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
