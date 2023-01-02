import 'dart:async';

import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_file_operations.dart';
import 'package:docs_manager/frontend/components/widgets/carousel_slider.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ContentFileView extends StatefulWidget {
  final String fileName;
  const ContentFileView(this.fileName, {super.key});

  @override
  State<ContentFileView> createState() => ContentFileViewState();
}

class ContentFileViewState extends State<ContentFileView> {
  List<Image> previewImgList = [];
  Widget buttonList = constants.emptyBox;
  FileModel fileData = FileModel(
      path: [],
      categoryName: "",
      subTitle1: "",
      isFavourite: false,
      dateUpload: "",
      extension: [],
      expiration: "");

  late StreamSubscription listenColor;
  Color catColor = Colors.black;
  @override
  void initState() {
    retrieveFileDataFromFileNameDB(widget.fileName, setFileData);
    super.initState();
  }

  @override
  void dispose() {
    listenColor.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DottedBorder(
                color: constants.mainBackColor,
                strokeWidth: 2,
                dashPattern: const [
                  5,
                  5,
                ],
                child: SizedBox(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyCarousel(previewImgList, removeImage, false)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const TitleText(
                    "Document name:",
                    Colors.black,
                  ),
                  const SizedBox(width: 5),
                  Text(widget.fileName,
                      style: const TextStyle(
                          color: constants.mainBackColor, fontSize: 20.0)),
                ],
              ),
              fileData.expiration != ""
                  ? Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const TitleText("Expiration:", Colors.black),
                          const SizedBox(width: 5),
                          Text(fileData.expiration,
                              style: const TextStyle(
                                  color: constants.mainBackColor,
                                  fontSize: 20.0)),
                        ],
                      ),
                    )
                  : constants.emptyBox,
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TitleText("Category name:", Colors.black),
                    const SizedBox(width: 5),
                    Text(fileData.categoryName,
                        style: TextStyle(color: catColor, fontSize: 20.0)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: buttonList,
              ),
            ],
          ),
        )
      ],
    );
  }

  //===================================================================================
  // remove image preview
  removeImage(Image w) {
    setState(() {
      previewImgList.remove(w);
    });
  }

  //===================================================================================
  // set preview list from DB
  setFileData(FileModel f) {
    Widget img = constants.defaultImg;
    setState(() {
      fileData = f;
      buttonList = ButtonsFileOperations(
          widget.fileName, fileData, moveToEditFile, removeCard);
      listenColor = getColorCategoryDB(setColor, fileData.categoryName);
    });
    for (int i = 0; i < fileData.path.length; i++) {
      readImageFileStorage(i, fileData.categoryName, widget.fileName,
              fileData.extension.elementAt(i) as String, img, context, true)
          .then(
        (value) => setState(() {
          previewImgList.add(value as Image);
        }),
      );
    }
  }

  //===================================================================================
  setColor(int c) {
    setState(() {
      catColor = Color(c);
    });
    listenColor.cancel();
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
//Remove File card
  removeCard(FileCard cardToDelete) {
    deleteFileDB(cardToDelete.file.categoryName, cardToDelete.fileName);
    deleteFileStorage(cardToDelete.file.extension,
        cardToDelete.file.categoryName, cardToDelete.fileName);
    onUpdateNFilesDB(cardToDelete.file.categoryName);
  }
  //========================================================
}
