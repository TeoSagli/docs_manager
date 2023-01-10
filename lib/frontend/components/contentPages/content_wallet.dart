import 'dart:async';

import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

import '../../../backend/delete_db.dart';
import '../../../backend/read_db.dart';
import '../../../backend/update_db.dart';
import '../widgets/file_card.dart';

class ContentWallet extends StatefulWidget {
  const ContentWallet({super.key});

  @override
  State<ContentWallet> createState() => ContentWalletState();
}

class ContentWalletState extends State<ContentWallet> {
  late StreamSubscription readCards;
  List<Widget> cardsList = [];

  @override
  void initState() {
    setState(() {
      readCards = retrieveAllExpirationFilesDB(
          fulfillCard, moveToFile, moveToEditFile, removeCard);
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
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Image.asset('assets/images/Wallet_empty.png',
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.5),
                ),
              )
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
