import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/google_integration.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_file_operations.dart';
import 'package:docs_manager/frontend/components/widgets/carousel_slider.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ContentFileView extends StatefulWidget {
  final String fileName;
  final Alert a;
  final ReadDB readDB;
  final UpdateDB updateDB;
  final DeleteDB deleteDB;
  final GoogleManager google;
  const ContentFileView(this.fileName, this.readDB, this.updateDB,
      this.deleteDB, this.google, this.a,
      {super.key});

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

  Color catColor = Colors.black;
  @override
  void initState() {
    widget.readDB.retrieveFileDataFromFileNameDB(widget.fileName, setFileData);
    super.initState();
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
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: MyCarousel(previewImgList, false,
                                  moveToOpenFile: moveToOpenFile,
                                  extensions: extList,
                                  catName: fileData.categoryName,
                                  fileName: widget.fileName),
                            ),
                          ],
                        ),
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
                    "File name:",
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
            widget.updateDB,
            addDocToDrive,
            addEventCalendar,
            removeEventCalendar,
            widget.a);
        widget.readDB.getColorCategoryDB(setColor, fileData.categoryName);
      });
      for (int i = 0; i < extList.length; i++) {
        widget.readDB.readImageFileStorage(i, fileData.categoryName,
            widget.fileName, extList[i], img, context, true, setImage);
      }
    }
  }

  //===================================================================================
  setColor(int c) {
    if (mounted) {
      setState(() {
        catColor = Color(c);
      });
    }
  }

  //===================================================================================
//Move router to Category View page
  moveToEditFile(fileName, context) {
    widget.a.navigateTo(
      '/files/edit/$fileName',
      context,
    );
  }

//========================================================
//Remove File card
  removeCard(FileModel cardToDelete) {
    widget.deleteDB.deleteFileDB(cardToDelete.categoryName, widget.fileName);
    widget.deleteDB.deleteFileStorage(
        cardToDelete.extension, cardToDelete.categoryName, widget.fileName);
    widget.updateDB.onUpdateNFilesDB(cardToDelete.categoryName);
  }

  //========================================================
  moveToOpenFile(String fileName, String catName, int pdfIndex) {
    widget.a.navigateTo(
      '/files/$catName/$fileName/$pdfIndex',
      context,
    );
  }

  //===================================================================================
  //Doc is uploaded to drive
  addDocToDrive(file) {
    var drive = widget.google;
    widget.a.onLoad(context);
    Future.delayed(const Duration(seconds: 5), () async {
      return await drive.upload(file, widget.fileName);
    }).then((value) {
      if ((value as AlertMessage).success) {
        widget.a.onSuccessDrive(context, '/files/view/${widget.fileName}');
      } else {
        widget.a.onErrorGeneric(context, value.message);
      }
    });
  }

  //===================================================================================
  //Event is added to calendar
  addEventCalendar(file) async {
    var calendar = widget.google;
    Future.delayed(const Duration(seconds: 1), () async {
      return await calendar.addCalendarExpiration(
          file, widget.fileName, file.expiration);
    }).then((value) {
      if ((value as AlertMessage).success) {
        widget.a.onSuccessCalendar(context, '/files/view/${widget.fileName}');
      } else {
        widget.a.onErrorGeneric(context, value.message);
      }
    });
  }

  //===================================================================================
  //Event is removed from calendar
  removeEventCalendar() {
    var calendar = widget.google;

    calendar.removeCalendarExpiration(widget.fileName);
    widget.a.onSuccessRemoveCalendar(context, '/files/view/${widget.fileName}');
  }
  //===================================================================================

  setImage(value) {
    if (mounted) {
      setState(() {
        previewImgList.add(value as Image);
      });
    }
  }
}
