import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../backend/models/file.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import '../../backend/read_db.dart';
import '../../backend/update_db.dart';
import '../../others/alerts.dart';
import 'abstract/card.dart';

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
            false)
        .then(
      (value) => setState(() {
        cardImage = value;
      }),
    );
    setState(() {
      isFav = widget.file.isFavourite;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x2B202529),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: MouseRegion(
          onEnter: ((event) => onHover()),
          onExit: ((event) => onExitHover()),
          child: GestureDetector(
            onTap: () => widget.function(widget.fileName, context),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                color: cardColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x25000000),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 4, 0, 4),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.file.subTitle1,
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    widget.fileName,
                                    style: const TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF101213),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    '#495242',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 10, 10, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: cardImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: const Color(0xFFF1F4F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.access_time_rounded,
                              color: Color(0xFF57636C),
                              size: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(widget.expiration),
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      color: constants.mainBackColor,
                                      icon: const Icon(
                                          Icons.mode_edit_outline_rounded),
                                      onPressed: () =>
                                          widget.moveToEditFilePage(
                                              widget.fileName, context),
                                    ),
                                    IconButton(
                                        color: constants.mainBackColor,
                                        icon: Icon(isFav
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded),
                                        onPressed: () {
                                          setState(() {
                                            isFav = !isFav;
                                          });
                                          updateFavouriteDB(
                                              widget.file.categoryName,
                                              widget.fileName,
                                              isFav);
                                        }),
                                    IconButton(
                                      color: Colors.redAccent,
                                      icon: const Icon(Icons.delete_rounded),
                                      onPressed: () => onDeleteFile(
                                          context, widget.removeCard, widget),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  setColor(int c) {
    setState(() {
      catColor = Color(c);
    });
  }
}
