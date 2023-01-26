import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_view_mode.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';

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
  Widget cardImage = constants.loadingWheel2;
  CategoryModel catModel =
      CategoryModel(path: "", nfiles: 0, colorValue: 0, order: 0);

  @override
  void initState() {
    if (mounted) {
      setState(() {
        widget.readDB.getCatModelFromCatNameDB(setCatModel, widget.catName);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fileCardsGrid.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        cardImage,
                        const Text(
                          "No documents yet!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )),
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
    if (mounted) {
      setState(() {
        fileCardsGrid = myCards;
        fileCardsList = myCardsList;
      });
    }
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

  //========================================================
  setCard(d) {
    if (mounted) {
      setState(() {
        cardImage = Image.memory(d!,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.6);
      });
      widget.readDB.retrieveFilesFromCategoryDB(widget.catName, fulfillCard,
          moveToFile, moveToEditFile, removeFileCard, context);
    }
  }

  //========================================================
  setCatModel(model) {
    if (mounted) {
      setState(() {
        catModel = model;
      });
      widget.readDB.readImageCategoryStorage(catModel.path, setCard);
    }
  }
  //========================================================
}
