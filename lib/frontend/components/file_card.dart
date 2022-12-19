import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'abstract/card.dart';

class FileCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FileCardState();
  final String fileName;
  final FileModel file;
  final dynamic function;
  final dynamic moveToEditFilePage;
  final dynamic removeCard;

  const FileCard(this.fileName, this.file, this.function,
      this.moveToEditFilePage, this.removeCard,
      {super.key});
}

class FileCardState extends State<FileCard> with MyCard {
  Widget cardImage = constants.loadingWheel;
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
    readImageFileStorage(widget.file.path.elementAt(0).toString(),
            widget.file.categoryName, widget.fileName, cardImage)
        .then(
      (value) => setState(() {
        cardImage = value;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
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
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 12, 0),
                                child: Icon(
                                  widget.file.icon,
                                  color: const Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Text(
                                widget.file.categoryName,
                                style: const TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                4, 0, 0, 0),
                            child: Text(
                              widget.fileName,
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                4, 4, 0, 0),
                            child: Text(
                              widget.file.subTitle1,
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            color: constants.mainBackColor,
                            icon: const Icon(Icons.mode_edit_outline_rounded),
                            onPressed: () => widget.moveToEditFilePage(
                                widget.fileName, context),
                          ),
                          IconButton(
                            color: Colors.redAccent,
                            icon: const Icon(Icons.delete_outline_rounded),
                            onPressed: () => onDeleteFile(
                                context, widget.removeCard, widget, "/"),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
