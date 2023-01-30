import 'dart:async';
import 'dart:io';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:docs_manager/frontend/components/widgets/buttons_upload_photo_pdf.dart';
import 'package:docs_manager/frontend/components/widgets/carousel_slider.dart';
import 'package:docs_manager/frontend/components/widgets/dropdown_menu.dart';

import 'package:docs_manager/frontend/components/widgets/input_field.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';

class ContentFileCreate extends StatefulWidget {
  final String catSelected;
  final dynamic retrieveCategoriesNamesDB;
  final dynamic checkElementExistDB;
  final dynamic loadFileToStorage;
  final dynamic createFile;
  final dynamic onUpdateNFilesDB;
  final dynamic alert;
  const ContentFileCreate(
      this.catSelected,
      this.checkElementExistDB,
      this.retrieveCategoriesNamesDB,
      this.createFile,
      this.loadFileToStorage,
      this.onUpdateNFilesDB,
      this.alert,
      {super.key});

  @override
  State<StatefulWidget> createState() => ContentFileCreateState();
}

class ContentFileCreateState extends State<ContentFileCreate> {
  final ImagePicker picker = ImagePicker();
  bool doesExist = false;
  TextEditingController docNameController = TextEditingController();
  String dateText = "";
  List<Image> previewImgList = [];
  List<String> nameImgList = [];
  List<String> pathImgList = [];
  Widget dropdown = constants.emptyBox;
  @override
  void initState() {
    setState(() {
      imageCache.clear();
      imageCache.clearLiveImages();

      docNameController.addListener(() {
        widget.checkElementExistDB(docNameController.text, "allFiles", setBool);
      });
      dropdown =
          MyDropdown(widget.catSelected, widget.retrieveCategoriesNamesDB);
    });
    previewImgList = [];
    super.initState();
  }

  @override
  void dispose() {
    docNameController.dispose();
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
                                      onPressed: () => widget.alert
                                          .openCalendar(context, onDateSelected,
                                              onDateUnselected),
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
            child: MyButton('Submit', onSubmit),
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
    widget.alert.onDateConfirmed(dateText, context);
  }

//===================================================================================
// User makes selection from calendar
  onDateUnselected(context) {
    setState(() {
      dateText = "";
    });
    widget.alert.onDateUnconfirmed(context);
  }

  //===================================================================================
// Upload photo from gallery and catch errors
  setPhotoFromGallery() async {
    XFile? imageGallery = XFile("");
    try {
      imageGallery = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: constants.imageQuality,
      );
      setState(
        () {
          setImage(
            Image(
              image: XFileImage(imageGallery!),
              fit: BoxFit.cover,
              width: 1000.0,
            ),
            imageGallery.name,
            imageGallery.path,
          );
        },
      );
    } catch (e) {
      widget.alert.onErrorImage(context);
    }
  }

  //===================================================================================
// Upload photo from file and catch errors
  setPhotoFromFile() async {
    await FilePicker.platform
        .pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    )
        .then((result) {
      if (result != null) {
        File file = File(result.files.first.path!);
        double widthValue = 500;
        double heightValue = MediaQuery.of(context).size.aspectRatio * 500;

        imageFromPdfFile(file).then((imageFileBytes) {
          try {
            setImage(
              Image.memory(
                imageFileBytes,
                fit: BoxFit.cover,
                width: widthValue,
                height: heightValue,
                cacheHeight: 500,
              ),
              result.files.first.name,
              result.files.first.path!,
            );
          } catch (e) {
            widget.alert.onErrorImage(context);
          }
        });
      } else {
        widget.alert.onErrorImage(context);
      }
    });
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

      setImage(
        Image(
          image: XFileImage(imageCamera!),
          fit: BoxFit.cover,
          width: 1000.0,
        ),
        imageCamera.name,
        imageCamera.path,
      );
    } catch (e) {
      widget.alert.onErrorImage(context);
    }
  }

//===================================================================================
// Submit category to db if everything is correct
  onSubmit() async {
    widget.checkElementExistDB(docNameController.text, "allFiles", setBool);
    String catName = (dropdown as MyDropdown).dropdownValue;
    List<String> listPaths = [];
    List<String> listExt = [];
    if (docNameController.text == "" ||
        docNameController.text == " " ||
        docNameController.text.contains(".")) {
      widget.alert.onErrorText(context);
    } else if (doesExist) {
      widget.alert.onErrorElementExisting(context, "File");
    } else if (previewImgList.isNotEmpty) {
      try {
        for (var element in previewImgList) {
          int index = previewImgList.indexOf(element);
          //prepare image and extension
          String path = pathImgList[index];
          String ext = nameImgList[index].split(".")[1];
          //create save name
          String saveName = "${docNameController.text}$index.$ext";
          listPaths.add(path);
          listExt.add(ext);
          //load file
          StreamSubscription listenLoading = widget.loadFileToStorage(
              path, docNameController.text, saveName, 'files/$catName');
          listenLoading.cancel();
        }
        //update category

        widget.createFile(catName, docNameController.text, dateText, listPaths,
            listExt, "files/$catName");
        widget.createFile(catName, docNameController.text, dateText, listPaths,
            listExt, "allFiles");
        widget.onUpdateNFilesDB(catName);
        widget.alert.onLoad(context);
        Future.delayed(const Duration(seconds: 5),
            () => widget.alert.onSuccess(context, '/'));
      } catch (e) {
        print("Error: $e");
      }
    } else {
      widget.alert.onErrorImage(context);
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
  // set image, name and path
  setImage(Image img, String name, String path) {
    setState(() {
      previewImgList.add(img);
      nameImgList.add(name);
      pathImgList.add(path);
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
