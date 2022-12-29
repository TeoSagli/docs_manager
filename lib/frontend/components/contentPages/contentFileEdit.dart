import 'dart:async';
import 'dart:io';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';

import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/buttons_upload_photo_pdf.dart';
import 'package:docs_manager/frontend/components/carouselSlider.dart';
import 'package:docs_manager/frontend/components/dropdown_menu.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
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
  TextEditingController textController2 = TextEditingController();
  TextEditingController _date = TextEditingController();
  List<Image> previewImgList = [];
  List<String> nameImgList = [];
  List<String> pathImgList = [];
  Widget dropdown = constants.emptyBox;
  late StreamSubscription listenFileData;
  FileModel fileData = FileModel(
      path: [],
      categoryName: "",
      subTitle1: "",
      isFavourite: false,
      dateUpload: "",
      extension: [],
      expiration: "");
  @override
  void initState() {
    setState(() {
      docNameController = TextEditingController(text: widget.fileName);
      listenFileData =
          retrieveFileDataFromFileNameDB(widget.fileName, setFileData);
    });
    super.initState();
  }

  @override
  void dispose() {
    listenFileData.cancel();
    docNameController.dispose();
    textController2.dispose();
    _date.dispose();
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
                                          setPhotoFromGallery, {}),
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
                                              : MyCarousel(previewImgList,
                                                  removeImage, true)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: _date,
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.calendar_today_rounded),
                                      labelText: "(Optional) Expiration"),
                                  onTap: (() async {
                                    DateTime? pickeddate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(
                                            DateTime.now().year + 100));

                                    if (pickeddate != null) {
                                      setState(() {
                                        _date.text = DateFormat('yyyy-MM-dd')
                                            .format(pickeddate);
                                      });
                                    }
                                  }),
                                ),
                              )
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
      allowedExtensions: ['pdf', 'pptx', 'xlsx', 'docx', 'doc', 'xls', 'ppt'],
      allowMultiple: false,
    );

    if (result != null) {
      File file = File(result.files.first.path!);
      Uint8List imageFileBytes = await imageFromPdfFile(file);
      try {
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
    List<String> listExts = [];
    // else if (!await isCategoryNew(docNameController!.text)) {
    // onErrorCategoryExisting();}
    if (docNameController.text == "" || docNameController.text == " ") {
      onErrorText(context);
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
          listExts.add(ext);
          //load file
          print("Name to save $saveName");
          StreamSubscription listenLoading = loadFileToStorage(
              path,
              docNameController.text,
              saveName,
              'files/${(dropdown as MyDropdown).dropdownValue}');
          listenLoading.cancel();
        }
        deleteFileStorage(
            fileData.extension, fileData.categoryName, widget.fileName);
        deleteFileDB(fileData.categoryName, widget.fileName);
        createFile((dropdown as MyDropdown).dropdownValue,
            docNameController.text, _date.text, listPaths, listExts);

        onUpdateNFiles((dropdown as MyDropdown).dropdownValue);
        onSuccess(context, '/categories');
      } catch (e) {
        print("Error: $e");
      }
    } else {
      onErrorImage(context);
    }
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
      _date = TextEditingController(text: f.expiration);

      dropdown = MyDropdown(fileData.categoryName);
      for (var element in f.path) {
        pathImgList.add(element as String);
      }
      for (var element in f.extension) {
        nameImgList.add(element as String);
      }
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
  // Convert file to image bytes
  Future<Uint8List> imageFromPdfFile(File pdfFile) async {
    PdfDocument document = await PdfDocument.openFile(pdfFile.path);
    PdfPage page = await document.getPage(1);
    PdfPageImage? pageImage =
        await page.render(width: page.width, height: page.height);
    return pageImage!.bytes;
  }

  //===================================================================================
}
