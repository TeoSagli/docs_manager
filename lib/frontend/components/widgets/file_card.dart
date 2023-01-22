import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class FileCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FileCardState();
  final String fileName;
  final FileModel file;
  final dynamic function;
  final dynamic moveToEditFilePage;
  final dynamic removeCard;
  final dynamic initCardFromDB;
  final dynamic initColorFromDB;
  final dynamic updateFavouriteDB;
  final dynamic delFunction;

  const FileCard(
      this.fileName,
      this.file,
      this.function,
      this.moveToEditFilePage,
      this.removeCard,
      this.initCardFromDB,
      this.initColorFromDB,
      this.updateFavouriteDB,
      this.delFunction,
      {super.key});
}

class FileCardState extends State<FileCard> {
  Widget cardImage = constants.loadingWheel;
  late bool isFav;
  Color catColor = Colors.grey;

  @override
  void initState() {
    widget.initColorFromDB(setColor, widget.file.categoryName);
    widget.initCardFromDB(
        0,
        widget.file.categoryName,
        widget.fileName,
        widget.file.extension.elementAt(0) as String,
        cardImage,
        context,
        false,
        setImage);

    setState(() {
      isFav = widget.file.isFavourite;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
      child: MouseRegion(
        child: GestureDetector(
          key: const Key("tap-card"),
          onTap: () => widget.function(widget.fileName, context),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x25000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: cardImage,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    4, 0, 0, 0),
                                child: Text(
                                  widget.file.categoryName,
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: catColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    4, 4, 0, 0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Center(
                                    child: Text(
                                      widget.fileName,
                                      style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    4, 4, 0, 0),
                                child: widget.file.expiration != ""
                                    ? const Text("Expires in:")
                                    : const Text(""),
                              ),
                              Text(
                                widget.file.expiration,
                                style: const TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                key: const Key("tap-move-to-edit"),
                                color: constants.mainBackColor,
                                icon:
                                    const Icon(Icons.mode_edit_outline_rounded),
                                onPressed: () => widget.moveToEditFilePage(
                                    widget.fileName, context),
                              ),
                              IconButton(
                                  key: const Key("tap-set-fav"),
                                  color: constants.mainBackColor,
                                  icon: Icon(isFav
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded),
                                  onPressed: () {
                                    setState(() {
                                      isFav = !isFav;
                                    });
                                    widget.updateFavouriteDB(
                                        widget.file.categoryName,
                                        widget.fileName,
                                        isFav);
                                  }),
                              IconButton(
                                key: const Key("tap-del"),
                                color: Colors.redAccent,
                                icon: const Icon(Icons.delete_rounded),
                                onPressed: () => widget.delFunction(
                                    context, widget.removeCard, widget),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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

  setImage(value) {
    setState(() {
      setState(() {
        cardImage = value;
      });
    });
  }
}
