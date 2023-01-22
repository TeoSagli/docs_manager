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
  const ContentFileEdit(this.fileName, {super.key});

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
  Widget dropdown = constants.emptyBox;
  late StreamSubscription s;
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
      s = retrieveFileDataFromFileNameDB(widget.fileName, setFileData);
    });
    super.initState();
  }

  @override
  void dispose() {
    docNameController.dispose();
    s.cancel();
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
                          const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
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
                                    const TitleText(
                                        "Document name:", Colors.black),
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                removeImage,
                                                true,
                                                extensions: extList,
                                              ),
                                      ),
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
                                            style: const TextStyle(
                                                color: Colors.black),
                                            dateText == ""
                                                ? "(Optional) Document expiration date"
                                                : dateText,
                                          ),
                                        ],
                                      ),
                                      onPressed: () => openCalendar(context,
                                          onDateSelected, onDateUnselected),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          dropdown,
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
    onDateConfirmed(dateText, context);
  }

//===================================================================================
// User makes selection from calendar
  onDateUnselected(context) {
    setState(() {
      dateText = "";
    });
    onDateUnconfirmed(context);
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
      onErrorImage(context);
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
        onErrorImage(context);
      }
    } else {
      onErrorImage(context);
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
      onErrorImage(context);
    }
  }

//===================================================================================
// Submit category to db if everything is correct
  onEdit() {
    List<String> listPaths = [];
    List<String> listExt = [];
    // else if (!await isCategoryNew(docNameController!.text)) {
    // onErrorCategoryExisting();}
    if (docNameController.text == "" || docNameController.text == " ") {
      onErrorText(context);
    } else if (doesExist && docNameController.text != widget.fileName) {
      onErrorElementExisting(context, "File");
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
          String saveName = "${docNameController.text}$index.$ext";
          listPaths.add(path);
          listExt.add(ext);
          //load file
          StreamSubscription listenLoading = loadFileToStorage(
              path,
              docNameController.text,
              saveName,
              'files/${(dropdown as MyDropdown).dropdownValue}');
          listenLoading.cancel();
        }

        //delet old version
        deleteFileStorage(
            fileData.extension, fileData.categoryName, widget.fileName);
        deleteFileDB(fileData.categoryName, widget.fileName);
        //update new version
        String catName = (dropdown as MyDropdown).dropdownValue;
        String fileName = docNameController.text;
        String expDate = dateText;
        createFile(
            catName, fileName, expDate, listPaths, listExt, "files/$catName");
        createFile(catName, fileName, expDate, listPaths, listExt, "allFiles");
        onUpdateNFilesDB((dropdown as MyDropdown).dropdownValue);
        s.cancel();
        setState(() {
          docNameController.removeListener(() => checkElementExistDB);
        });
        onSuccess(context, '/');
      } catch (e) {
        print("Error: $e");
      }
    } else {
      onErrorImage(context);
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
      dropdown = MyDropdown(fileData.categoryName, retrieveCategoriesNamesDB);
      for (var element in f.path) {
        pathImgList.add(element as String);
      }
      for (var element in f.extension) {
        nameImgList.add(element as String);
      }
      docNameController.addListener(() {
        checkElementExistDB(docNameController.text, "allFiles", setBool);
      });
    });
    for (int i = 0; i < extList.length; i++) {
      readImageFileStorage(i, fileData.categoryName, widget.fileName,
              extList[i], img, context, true, setImage)
          .then(
        (value) => setState(() {
          previewImgList.add(value as Image);
        }),
      );
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
