import 'dart:async';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/create_db.dart';

import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/buttons_upload_photo_pdf.dart';
import 'package:docs_manager/frontend/components/carouselSlider.dart';

import 'package:docs_manager/frontend/components/dropdown_menu.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';

import 'package:docs_manager/others/alerts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ContentFileCreate extends StatefulWidget {
  final String catSelected;
  const ContentFileCreate(this.catSelected, {super.key});

  @override
  State<StatefulWidget> createState() => ContentFileCreateState();
}

class ContentFileCreateState extends State<ContentFileCreate> {
  final ImagePicker picker = ImagePicker();
  TextEditingController docNameController = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  final TextEditingController _date = TextEditingController();
  List<Image> previewImgList = [];
  List<String> nameImgList = [];
  List<String> pathImgList = [];
  Widget dropdown = constants.emptyBox;
  @override
  void initState() {
    setState(() {
      dropdown = MyDropdown(widget.catSelected);
    });
    previewImgList = [];
    super.initState();
  }

  @override
  void dispose() {
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
                                          setPhotoFromGallery),
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
                                padding: const EdgeInsets.all(30.0),
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
            child: MyButton('Submit', onSubmit),
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
        imageQuality: constants.imageQuality,
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
  onSubmit() {
    List<String> listPaths = [];
    List<String> listExt = [];
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
          String ext = nameImgList[index].split(".")[1];
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
        createFile((dropdown as MyDropdown).dropdownValue,
            docNameController.text, _date.text, listPaths, listExt);
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
}
