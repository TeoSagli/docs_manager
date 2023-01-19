import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:docs_manager/frontend/components/widgets/title_text_v2.dart';
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
  void dispose() {
    readCards.cancel();
    super.dispose();
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
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const TitleText2('Expiring documents will be here'),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CarouselSlider(
                              items: cardsList,
                              options: CarouselOptions(
                                height: 250,
                                viewportFraction: 0.35,
                                autoPlay: false,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.vertical,
                                enableInfiniteScroll: false,
                                initialPage: cardsList.length ~/ 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
      readCards.cancel();
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
