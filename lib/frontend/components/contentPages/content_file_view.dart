import 'dart:async';

import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/google_integration.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_file_operations.dart';
import 'package:docs_manager/frontend/components/widgets/carousel_slider.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:docs_manager/others/alerts.dart';
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
  List<String> extList = [];
  Widget buttonList = constants.emptyBox;
  FileModel fileData = FileModel(
      path: [],
      categoryName: "",
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
                  child: previewImgList == []
                      ? constants.loadingWheel2
                      : MyCarousel(previewImgList, removeImage, false,
                          moveToOpenFile: moveToOpenFile,
                          extensions: extList,
                          catName: fileData.categoryName,
                          fileName: widget.fileName),
                ),
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
  setFileData(FileModel f) async {
    Widget img = constants.defaultImg;
    if (mounted) {
      setState(() {
        fileData = f;
        for (var element in f.extension) {
          extList.add(element as String);
        }
        buttonList = ButtonsFileOperations(
            widget.fileName,
            fileData,
            moveToEditFile,
            removeCard,
            updateFavouriteDB,
            addDocToDrive,
            addEventCalendar,
            removeEventCalendar);
        listenColor = getColorCategoryDB(setColor, fileData.categoryName);
      });
      for (int i = 0; i < extList.length; i++) {
        Image value = (await readImageFileStorage(
            i,
            fileData.categoryName,
            widget.fileName,
            extList[i],
            img,
            context,
            true,
            setImage) as Image);
        setState(() {
          previewImgList.add(value);
        });
      }
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
  moveToOpenFile(String fileName, String catName, int pdfIndex) {
    Navigator.pushNamed(
      context,
      '/files/$catName/$fileName/$pdfIndex',
    );
  }

  //===================================================================================
  //Doc is uploaded to drive
  addDocToDrive(file) async {
    var drive = GoogleManager();
    await drive.upload(file, widget.fileName).then((alertMessage) {
      if (alertMessage.success) {
        onSuccess(context, alertMessage.message);
      } else {
        onErrorGeneric(context, alertMessage.message);
      }
    });
  }

  //===================================================================================
  //Event is added to calendar
  addEventCalendar(file) async {
    var calendar = GoogleManager();

    await calendar
        .addCalendarExpiration(file, widget.fileName, file.expiration)
        .then(
      (alertMessage) {
        if (alertMessage.success) {
          onSuccess(context, alertMessage.message);
        } else {
          onErrorGeneric(context, alertMessage.message);
        }
      },
    );
  }

  //===================================================================================
  //Event is removed from calendar
  removeEventCalendar() {
    var calendar = GoogleManager();

    calendar.removeCalendarExpiration(widget.fileName);
    onSuccess(context, "Event removed");
  }
  //===================================================================================

  setImage(value) {
    setState(() {
      previewImgList.add(value as Image);
    });
  }
}
