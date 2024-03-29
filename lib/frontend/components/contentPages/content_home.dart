import 'package:carousel_slider/carousel_slider.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_view_mode.dart';
import 'package:docs_manager/frontend/components/widgets/title_text_v2.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ContentHome extends StatefulWidget {
  final dynamic readDB;
  final dynamic deleteDB;
  final dynamic updateDB;
  final dynamic alert;
  const ContentHome(this.readDB, this.deleteDB, this.updateDB, this.alert,
      {super.key});

  @override
  State<ContentHome> createState() => ContentHomeState();
}

class ContentHomeState extends State<ContentHome> {
  List<Widget> fileCardsGrid = [constants.emptyBox];
  List<Widget> fileCardsList = [constants.emptyBox];

  List<Container> categoriesCardsList = [];
  List<int> itemsList = [];
  int length = 0;
  int currMode = 0;

  @override
  void initState() {
    imageCache.clear();
    imageCache.clearLiveImages();

    widget.readDB.retrieveAllFilesDB(
        fulfillFileCards, moveToFile, moveToEditFile, removeFileCard, false);

    widget.readDB
        .retrieveCategoryOverviewDB(fulfillCategoriesCards, moveToCategory);

    super.initState();
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
                  const TitleText2('All Categories'),
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
                ],
              ),
            ),
          ),
        ]),
        const TitleText2('Recent Files'),
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
                      key: const Key("mode-change"),
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
  /// Move to file page
  moveToFile(fileName, context) {
    widget.alert.navigateTo(
      '/files/view/$fileName',
      context,
    );
  }

//========================================================
  ///Fill files card
  fulfillFileCards(
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
  ///Fill categories card
  fulfillCategoriesCards(
    List<Container> myCards,
    List<int> myOrders,
  ) {
    if (mounted) {
      setState(() {
        itemsList = myOrders;
        categoriesCardsList = myCards;
      });
    }
  }

//===================================================================================
  ///Move router to File Edit page
  moveToEditFile(fileName, context) {
    widget.alert.navigateTo(
      '/files/edit/$fileName',
      context,
    );
  }

//========================================================
  ///Move router to Category View page
  moveToCategory(catName, context) {
    widget.alert.navigateTo(
      '/categories/view/$catName',
      context,
    );
  }

  //========================================================
  ///Remove card from list
  removeFileCard(cardToDelete) {
    widget.deleteDB
        .deleteFileDB(cardToDelete.file.categoryName, cardToDelete.fileName);
    widget.deleteDB.deleteFileStorage(cardToDelete.file.extension,
        cardToDelete.file.categoryName, cardToDelete.fileName);

    widget.updateDB.onUpdateNFilesDB(cardToDelete.file.categoryName);
    switch (currMode) {
      case 0:
        if (mounted) {
          setState(() {
            fileCardsList.removeAt(fileCardsGrid.indexOf(cardToDelete));
            fileCardsGrid.remove(cardToDelete);
          });
        }
        break;
      case 1:
        if (mounted) {
          setState(() {
            fileCardsGrid.removeAt(fileCardsList.indexOf(cardToDelete));
            fileCardsList.remove(cardToDelete);
          });
        }
        break;
    }
  }
}
  //========================================================
