import 'dart:async';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../backend/models/file.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import '../../../backend/read_db.dart';
import '../abstract/card.dart';

class WalletCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WalletCardState();
  final String fileName;
  final FileModel file;
  final dynamic function;
  final dynamic moveToEditFilePage;
  final dynamic removeCard;
  final DateTime expiration;

  WalletCard(this.fileName, String expiration, this.file, this.function,
      this.moveToEditFilePage, this.removeCard,
      {super.key})
      : expiration = DateTime.parse(expiration);
}

class WalletCardState extends State<WalletCard> with MyCard {
  Widget cardImage = constants.loadingWheel;
  late StreamSubscription listenColor;
  late bool isFav;
  Color catColor = Colors.grey;

  @override
  onExitHover() {
    setState(() {
      cardColor = Colors.white;
    });
  }

  @override
  onHover() {
    setState(() {
      cardColor = Colors.white30;
    });
  }

  @override
  void initState() {
    listenColor = getColorCategoryDB(setColor, widget.file.categoryName);
    readImageFileStorage(
            0,
            widget.file.categoryName,
            widget.fileName,
            widget.file.extension.elementAt(0) as String,
            cardImage,
            context,
            true)
        .then(
      (value) {
        if (mounted) {
          setState(() {
            cardImage = value;
          });
        }
      },
    );
    setState(() {
      isFav = widget.file.isFavourite;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.function(widget.fileName, context),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: /*DottedBorder(
                color: constants.mainBackColor,
                strokeWidth: 1,
                dashPattern: const [
                  5,
                  5,
                ],
                child: */
                  SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: cardImage,
                    ),
                  ],
                ),
              ),
              //    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 15, 15),
              child: Container(
                decoration: const BoxDecoration(
                  color: constants.mainBackColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      color: Color(0x2F1D2429),
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(widget.expiration),
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  setColor(int c) {
    if (mounted) {
      setState(() {
        catColor = Color(c);
      });
    }
  }
}
