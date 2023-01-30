import 'dart:async';
import 'dart:io';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';

import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_upload_photo_pdf.dart';
import 'package:docs_manager/frontend/components/widgets/carousel_slider.dart';
import 'package:docs_manager/frontend/components/widgets/dropdown_menu.dart';
import 'package:docs_manager/frontend/components/widgets/input_field.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:docs_manager/frontend/components/widgets/title_text_v2.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';

class ContentFileEdit extends StatefulWidget {
  final String fileName;
  final Alert a;

  final ReadDB readDB;
  final UpdateDB updateDB;
  final DeleteDB deleteDB;
  final CreateDB createDB;
  const ContentFileEdit(this.fileName, this.readDB, this.createDB,
      this.updateDB, this.deleteDB, this.a,
      {super.key});

  @override
  State<ContentFileEdit> createState() => ContentFileEditState();
}

class ContentFileEditState extends State<ContentFileEdit> {
  final ImagePicker picker = ImagePicker();
  late TextEditingController docNameController;

  bool doesExist = false;
  List<Image> previewImgList = [];
  List<String> nameImgList = [];
  List<String> pathImgList = [];
  List<String> extList = [];
  String dateText = "";
  FileModel fileData = FileModel(
      path: [],
      categoryName: "",
      isFavourite: false,
      dateUpload: "",
      extension: [],
      expiration: "");
  @override
  void initState() {
    setState(() {
      docNameController = TextEditingController(text: widget.fileName);
    });
    widget.readDB.retrieveFileDataFromFileNameDB(widget.fileName, setFileData);

    super.initState();
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
                              Align(
                                alignment: const AlignmentDirectional(0, -0.9),
                                child: Column(
                                  children: [
                                    const TitleText("File name:", Colors.black),
                                    InputField(docNameController, true),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const TitleText(
                                        "Add document from:", Colors.black),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8, 8, 8, 8),
                                      child: ButtonsUploadPhotoes(
                                          setPhotoFromCamera,
                                          setPhotoFromGallery,
                                          setPhotoFromFile),
                                    ),
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
                                          child: previewImgList.isEmpty
                                              ? SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  child: const Center(
                                                    child: Text(
                                                      "Images preview",
                                                      style: TextStyle(
                                                          color: constants
                                                              .mainBackColor,
                                                          fontSize: 16.0),
                                                    ),
                                                  ),
                                                )
                                              : MyCarousel(
                                                  previewImgList,
                                                  true,
                                                  removeImg: removeImage,
                                                  moveToOpenFile: null,
                                                )),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: OutlinedButton(
                                      key: const Key("tap-date"),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                5, 0, 10, 0),
                                            child: Icon(
                                              Icons.calendar_today_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            key: const Key("text-date"),
                                            style: const TextStyle(
                                                color: Colors.black),
                                            dateText == ""
                                                ? "(Optional) Document expiration date"
                                                : dateText,
                                          ),
                                        ],
                                      ),
                                      onPressed: () => widget.a.openCalendar(
                                          context,
                                          onDateSelected,
                                          onDateUnselected),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.all(10),
                            child: TitleText2(fileData.categoryName),
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
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: MyButton('Edit', onEdit),
          ),
        ),
      ],
    );
  }

//===================================================================================
// User makes selection from calendar
  onDateSelected(DateTime value, context) {
    setState(() {
      dateText = DateFormat('yyyy-MM-dd').format(value);
    });
    widget.a.onDateConfirmed(dateText, context);
  }

//===================================================================================
// User makes selection from calendar
  onDateUnselected(context) {
    setState(() {
      dateText = "";
    });
    widget.a.onDateUnconfirmed(context);
  }

  //===================================================================================
// Upload photo from gallery and catch errors
  setPhotoFromGallery() async {
    XFile? imageGallery = XFile("");
    try {
      imageGallery = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: constants.imageQuality * 2,
      );
      setState(
        () {
          previewImgList.add(
            Image(
              image: XFileImage(imageGallery!),
              fit: BoxFit.cover,
              width: 1000.0,
            ),
          );
          nameImgList.add(imageGallery.name);
          pathImgList.add(imageGallery.path);
          extList.add(imageGallery.name.split(".")[1]);
        },
      );
    } catch (e) {
      widget.a.onErrorImage(context);
    }
  }

  //===================================================================================
// Upload photo from file and catch errors
  setPhotoFromFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      try {
        File file = File(result.files.first.path!);
        Uint8List imageFileBytes = await imageFromPdfFile(file);

        setState(
          () {
            previewImgList.add(
              Image.memory(
                imageFileBytes,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
            );
            nameImgList.add(result.files.first.name);
            pathImgList.add(result.files.first.path!);
            extList.add("pdf");
          },
        );
      } catch (e) {
        widget.a.onErrorImage(context);
      }
    } else {
      widget.a.onErrorImage(context);
    }
  }

//===================================================================================
// Upload photo from camera and catch errors
  setPhotoFromCamera() async {
    XFile? imageCamera = XFile("");
    try {
      imageCamera = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: constants.imageQuality,
      );
      setState(
        () {
          previewImgList.add(
            Image(
              image: XFileImage(imageCamera!),
              fit: BoxFit.cover,
              width: 1000.0,
            ),
          );
          nameImgList.add(imageCamera.name);
          pathImgList.add(imageCamera.path);
          extList.add(imageCamera.name.split(".")[1]);
        },
      );
    } catch (e) {
      widget.a.onErrorImage(context);
    }
  }

//===================================================================================
// Submit category to db if everything is correct
  onEdit() {
    String catName = fileData.categoryName;
    String fileName = docNameController.text;
    String expDate = dateText;
    List<String> listPaths = [];
    List<String> listExt = [];
    // else if (!await isCategoryNew(docNameController!.text)) {
    // onErrorCategoryExisting();}
    if (fileName == "" || fileName == " " || fileName.contains(".")) {
      widget.a.onErrorText(context);
    } else if (doesExist && fileName != widget.fileName) {
      widget.a.onErrorElementExisting(context, "File");
    } else if (previewImgList.isNotEmpty) {
      try {
        for (var element in previewImgList) {
          int index = previewImgList.indexOf(element);
          //prepare image and extension
          String path = pathImgList[index];
          String ext = nameImgList[index].split(".").length == 1
              ? nameImgList[index]
              : nameImgList[index].split(".")[1];
          //create save name
          String saveName = "$fileName$index.$ext";
          listPaths.add(path);
          listExt.add(ext);
          //load file
          StreamSubscription listenLoading = widget.createDB
              .loadFileToStorage(path, catName, saveName, 'files/$catName');
          listenLoading.cancel();
        }

        //delet old version
        widget.deleteDB.deleteFileStorage(
            fileData.extension, fileData.categoryName, widget.fileName);
        widget.deleteDB.deleteFileDB(fileData.categoryName, widget.fileName);
        //update new version

        widget.createDB.createFile(
            catName, fileName, expDate, listPaths, listExt, "files/$catName");
        widget.createDB.createFile(
            catName, fileName, expDate, listPaths, listExt, "allFiles");

        setState(() {
          docNameController
              .removeListener(() => widget.readDB.checkElementExistDB);
        });
        widget.a.onLoad(context);
        Future.delayed(
            const Duration(seconds: 3), () => widget.a.onSuccess(context, '/'));
      } catch (e) {
        print("Error: $e");
      }
    } else {
      widget.a.onErrorImage(context);
    }
  }

  //===================================================================================
  // set if file exists
  setBool(bool b) {
    setState(() {
      doesExist = b;
    });
  }

//===================================================================================
  // Submit category to db if everything is correct
  removeImage(Image w) {
    setState(() {
      nameImgList.removeAt(previewImgList.indexOf(w));
      pathImgList.removeAt(previewImgList.indexOf(w));
      previewImgList.remove(w);
    });
  }

  //===================================================================================
  // set preview list from DB
  setPreviewList(List<Image> list) {
    setState(() {
      previewImgList = list;
    });
  }

  //===================================================================================
  // set preview list from DB
  setFileData(FileModel f) {
    Widget img = constants.defaultImg;
    setState(() {
      fileData = f;
      for (var element in f.extension) {
        extList.add(element as String);
      }
      dateText = f.expiration;
      for (var element in f.path) {
        pathImgList.add(element as String);
      }
      for (var element in f.extension) {
        nameImgList.add(element as String);
      }
      docNameController.addListener(() {
        widget.readDB
            .checkElementExistDB(docNameController.text, "allFiles", setBool);
      });
    });
    for (int i = 0; i < extList.length; i++) {
      widget.readDB.readImageFileStorage(i, fileData.categoryName,
          widget.fileName, extList[i], img, context, true, setImage);
    }
  }

  //===================================================================================
  // Convert file to image bytes
  Future<Uint8List> imageFromPdfFile(File pdfFile) async {
    PdfDocument document = await PdfDocument.openFile(pdfFile.path);
    PdfPage page = await document.getPage(1);
    PdfPageImage? pageImage =
        await page.render(width: page.width, height: page.height);
    return pageImage!.bytes;
  }

  setImage(value) {
    setState(() {
      previewImgList.add(value as Image);
    });
  }
  //===================================================================================
}
