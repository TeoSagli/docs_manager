import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_view_mode.dart';
import 'package:flutter/material.dart';

import '../../../backend/delete_db.dart';
import '../../../backend/read_db.dart';
import '../../../backend/update_db.dart';
import '../widgets/file_card.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ContentHome extends StatefulWidget {
  const ContentHome({super.key});

  @override
  State<ContentHome> createState() => ContentHomeState();
}

class ContentHomeState extends State<ContentHome> {
  late StreamSubscription readFileCards;
  List<Widget> fileCardsGrid = [constants.emptyBox];
  List<Widget> fileCardsList = [constants.emptyBox];

  late StreamSubscription readCategoriesCards;
  List<Container> categoriesCardsList = [];
  List<int> itemsList = [];
  int length = 0;
  int currMode = 0;

  @override
  void initState() {
    setState(() {
      readFileCards = retrieveAllFilesDB(
          fulfillFileCards, moveToFile, moveToEditFile, removeFileCard, false);

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
  void dispose() {
    readFileCards.cancel();
    readCategoriesCards.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 7,
                              color: Color(0x2F1D2429),
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
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
                    ),
                    Expanded(
                      child: CarouselSlider(
                        items: categoriesCardsList,
                        options: CarouselOptions(
                          viewportFraction: 0.6,
                          autoPlay: false,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 7,
                  color: Color(0x2F1D2429),
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
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
        ),
        fileCardsGrid.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Image.asset('assets/images/No_docs.png',
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.5),
                  ),
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
              ),
      ],
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
  /// Move to file page
  moveToFile(fileName, context) {
    Navigator.pushNamed(
      context,
      '/files/view/$fileName',
    );
  }

//========================================================
  ///Fill files card
  fulfillFileCards(
    List<Widget> myCardsGrid,
    List<Widget> myCardsList,
  ) {
    setState(() {
      fileCardsGrid = myCardsGrid;
      fileCardsList = myCardsList;
      readFileCards.cancel();
    });
  }

//===================================================================================
  ///Fill categories card
  fulfillCategoriesCards(
    List<Container> myCards,
    List<int> myOrders,
  ) {
    setState(() {
      itemsList = myOrders;
      categoriesCardsList = myCards;
      readCategoriesCards.cancel();
    });
  }

//===================================================================================
  ///Move router to File Edit page
  moveToEditFile(fileName, context) {
    Navigator.pushNamed(
      context,
      '/files/edit/$fileName',
    );
  }

//========================================================
  ///Move router to Category View page
  moveToCategory(catName, context) {
    Navigator.pushNamed(
      context,
      '/categories/view/$catName',
    );
  }

  //========================================================
  ///Remove card from list
  removeFileCard(FileCard cardToDelete) {
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
  //========================================================
