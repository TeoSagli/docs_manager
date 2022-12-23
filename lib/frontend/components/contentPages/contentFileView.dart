import 'dart:async';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';

import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/buttons_upload_photo_pdf.dart';
import 'package:docs_manager/frontend/components/carouselSlider.dart';

import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';

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
  FileModel fileData = FileModel(
      path: [],
      categoryName: "",
      subTitle1: "",
      isFavourite: false,
      dateUpload: "",
      extension: [],
      expiration: "");
  late StreamSubscription listenFileData;
  late StreamSubscription listenColor;
  Color catColor = Colors.black;
  @override
  void initState() {
    listenFileData =
        retrieveFileDataFromFileNameDB(widget.fileName, setFileData);
    super.initState();
  }

  @override
  void dispose() {
    listenFileData.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: const AlignmentDirectional(0, -0.9),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: MyCarousel(previewImgList,
                                              removeImage, false)),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const TitleText(
                                          "Document name:", Colors.black),
                                      Text(widget.fileName,
                                          style: const TextStyle(
                                              color: constants.mainBackColor,
                                              fontSize: 20.0)),
                                    ],
                                  ),
                                  fileData.expiration != ""
                                      ? Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const TitleText(
                                                  "Expiration:", Colors.black),
                                              Text(fileData.expiration,
                                                  style: const TextStyle(
                                                      color: constants
                                                          .mainBackColor,
                                                      fontSize: 20.0)),
                                            ],
                                          ),
                                        )
                                      : constants.emptyBox,
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const TitleText(
                                            "Category name:", Colors.black),
                                        Text(fileData.categoryName,
                                            style: TextStyle(
                                                color: catColor,
                                                fontSize: 20.0)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
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
      listenColor = getColorCategory(setColor, fileData.categoryName);
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
  }
  //===================================================================================
}
