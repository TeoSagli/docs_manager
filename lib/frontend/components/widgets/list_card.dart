import 'dart:async';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import '../abstract/card.dart';

class ListCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListCardState();
  final String fileName;
  final FileModel file;
  final dynamic function;
  final dynamic moveToEditFilePage;
  final dynamic removeCard;

  const ListCard(this.fileName, this.file, this.function,
      this.moveToEditFilePage, this.removeCard,
      {super.key});
}

class ListCardState extends State<ListCard> with MyCard {
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
    setState(() {
      isFav = widget.file.isFavourite;
    });
    super.initState();
  }

  @override
  void dispose() {
    listenColor.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
      child: MouseRegion(
        onEnter: ((event) => onHover()),
        onExit: ((event) => onExitHover()),
        child: GestureDetector(
          onTap: () => widget.function(widget.fileName, context),
          child: Container(
            width: MediaQuery.of(context).size.width,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                          child: Image.asset(
                              'assets/images/${widget.file.categoryName}.png',
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            widget.fileName,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          color: constants.mainBackColor,
                          icon: const Icon(Icons.mode_edit_outline_rounded),
                          onPressed: () => widget.moveToEditFilePage(
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
                              updateFavouriteDB(widget.file.categoryName,
                                  widget.fileName, isFav);
                            }),
                        IconButton(
                          color: Colors.redAccent,
                          icon: const Icon(Icons.delete_rounded),
                          onPressed: () =>
                              onDeleteFile(context, widget.removeCard, widget),
                        ),
                      ],
                    )
                  ],
                ),
              ],
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
