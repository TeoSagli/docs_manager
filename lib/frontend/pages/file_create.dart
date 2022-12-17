import 'dart:async';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/category_create_db.dart';
import 'package:docs_manager/backend/file_create_db.dart';
import 'package:docs_manager/backend/file_update_db.dart';
import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/button_icon_function.dart';
import 'package:docs_manager/frontend/components/dropdown_menu.dart';
import 'package:docs_manager/frontend/components/image_network.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:docs_manager/frontend/components/widget_preview.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';

class FileCreatePage extends StatefulWidget {
  const FileCreatePage({super.key});

  @override
  State<StatefulWidget> createState() => FileCreateState();
}

class FileCreateState extends State<FileCreatePage> {
  final ImagePicker picker = ImagePicker();
  bool hasUploaded = false;
  late StreamSubscription listenNFiles;
  XFile? imageGallery;
  XFile? imageCamera;
  TextEditingController docNameController = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  List<Widget> previewList = [];
  MyDropdown dropdown = MyDropdown("");

  @override
  void initState() {
    previewList = [];
    super.initState();
  }

  @override
  void dispose() {
    listenNFiles.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar("File creation", true, context),
      bottomNavigationBar: MyBottomBar(context, 4),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, -0.9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 30, 10, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0, -0.9),
                                    child: Column(
                                      children: [
                                        const TitleText(
                                            "Document name:", Colors.black),
                                        InputField(docNameController),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const TitleText(
                                            "Add document from:", Colors.black),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(8, 8, 8, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MyButtonIcon(
                                                  'CAMERA',
                                                  setPhotoFromCamera,
                                                  Icons.photo_camera),
                                              MyButtonIcon(
                                                  'GALLERY',
                                                  setPhotoFromGallery,
                                                  Icons.image),
                                              const MyButtonIcon('PDF, TXT....',
                                                  {}, Icons.picture_as_pdf),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: previewList.isEmpty
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
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
                              //==================================WIDGET CATEGORIES CHOICE
                              dropdown,
                              //==================================
                              /* Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 30, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const TitleText(
                                        '(Optional) field', Colors.black),
                                    InputField(textController2)
                                  ],
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ],
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
          ),
        ),
      ),
    );
  }

//===================================================================================
// Upload photo from gallery and catch errors
  setPhotoFromGallery() async {
    try {
      imageGallery = await picker.pickImage(source: ImageSource.gallery);
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
      imageCamera = await picker.pickImage(source: ImageSource.camera);
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
          String saveName = "$index.$ext";
          listPaths.add(saveName);
          //load file
          StreamSubscription listenLoading = loadFileToStorage(
              img.path,
              docNameController.text,
              saveName,
              'files/${dropdown.dropdownValue}/${docNameController.text}');
          listenLoading.cancel();
        }
        createFile(dropdown.dropdownValue, docNameController.text, listPaths);
        listenNFiles = onUpdateNFiles(dropdown.dropdownValue);
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
