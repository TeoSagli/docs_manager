import 'dart:async';

import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/frontend/components/file_card.dart';
import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/bottom_bar.dart';

class CategoryViewPage extends StatefulWidget {
  final String catName;
  const CategoryViewPage({required this.catName, super.key});

  @override
  State<StatefulWidget> createState() => CategoryViewPageState();
}

class CategoryViewPageState extends State<CategoryViewPage> {
  late StreamSubscription readCards;
  List<Widget> cardsList = [];
//===================================================================================
// Activate listeners
  @override
  void initState() {
    setState(() {
      readCards = retrieveFilesDB(widget.catName, fulfillCard, moveToFile);
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
      bottomNavigationBar: MyBottomBar(context, 4),
      appBar: MyAppBar('View category ${widget.catName}', true, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
            spacing: 8,
            runSpacing: 12,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: cardsList.isEmpty ? [] : cardsList),
      ), /* Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Color(0x230F1113),
                    offset: Offset(0, 4),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Color(0x230F1113),
                    offset: Offset(0, 4),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          
        ],
      ),*/
    );
  }

//===================================================================================
// Move to file page
  moveToFile(fileName, context) {
    Navigator.pushNamed(
      context,
      '/files/view/$fileName',
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

}
