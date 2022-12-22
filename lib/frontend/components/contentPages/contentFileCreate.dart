import 'dart:async';
import 'package:docs_manager/backend/create_db.dart';

import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/button_icon_function.dart';
import 'package:docs_manager/frontend/components/dropdown_menu.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:docs_manager/frontend/components/widget_preview.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';

class ContentFileCreate extends StatefulWidget {
  final String catSelected;
  const ContentFileCreate(this.catSelected, {super.key});

  @override
  State<StatefulWidget> createState() => ContentFileCreateState();
}

class ContentFileCreateState extends State<ContentFileCreate> {
  final ImagePicker picker = ImagePicker();
  bool hasUploaded = false;
  late StreamSubscription listenNFiles;
  XFile? imageGallery = XFile("");
  XFile? imageCamera = XFile("");
  TextEditingController docNameController = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  List<Widget> previewList = [];
  Widget dropdown = constants.emptyBox;
  late StreamSubscription listenColor;
  @override
  void initState() {
    setState(() {
      dropdown = MyDropdown(widget.catSelected);
    });
    previewList = [];
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
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MyButtonIcon(
                                              'CAMERA',
                                              setPhotoFromCamera,
                                              Icons.photo_camera),
                                          MyButtonIcon('GALLERY',
                                              setPhotoFromGallery, Icons.image),
                                          const MyButtonIcon('PDF, TXT....', {},
                                              Icons.picture_as_pdf),
                                        ],
                                      ),
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
                                        child: previewList.isEmpty
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
                                            : ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: previewList),
                                      ),
                                    ),
                                  ],
                                ),
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
// Upload photo from gallery and catch errors
  setPhotoFromGallery() async {
    try {
      imageGallery = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 15,
      );
      setState(
        () {
          previewList.add(DocumentPreview(imageGallery!,
              MediaQuery.of(context).size.width * 0.9, removeImage));
          hasUploaded = true;
        },
      );
    } catch (e) {
      onErrorImage(context);
    }
  }

//===================================================================================
// Upload photo from camera and catch errors
  setPhotoFromCamera() async {
    try {
      imageCamera = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 15,
      );
      setState(
        () {
          previewList.add(DocumentPreview(imageCamera!,
              MediaQuery.of(context).size.width * 0.9, removeImage));
          hasUploaded = true;
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
    // else if (!await isCategoryNew(docNameController!.text)) {
    // onErrorCategoryExisting();}
    if (docNameController.text == "" || docNameController.text == " ") {
      onErrorText(context);
    } else if (previewList.isNotEmpty) {
      try {
        for (var element in previewList) {
          //prepare image and extension
          XFile img = ((element as DocumentPreview).loadedImage);
          String ext = img.name.toString().split(".")[1];
          //create save name
          int index = previewList.indexOf(element);
          String saveName = "${docNameController.text}$index.$ext";
          listPaths.add(saveName);
          //load file
          StreamSubscription listenLoading = loadFileToStorage(
              img.path,
              docNameController.text,
              saveName,
              'files/${(dropdown as MyDropdown).dropdownValue}');
          listenLoading.cancel();
        }
        createFile((dropdown as MyDropdown).dropdownValue,
            docNameController.text, listPaths);
        onUpdateNFiles((dropdown as MyDropdown).dropdownValue);
        onSuccess(context, '/');
      } catch (e) {
        print("Error: $e");
      }
    } else {
      onErrorImage(context);
    }
  }

//===================================================================================
  // Submit category to db if everything is correct
  removeImage(Widget w) {
    print("List status before${previewList.toString()}");
    setState(() {
      previewList.remove(w);
      hasUploaded = false;
      imageGallery = null;
    });
    print("List status after${previewList.toString()}");
  }
  //===================================================================================

}
