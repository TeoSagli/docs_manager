import 'dart:async';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:docs_manager/frontend/components/widgets/input_field.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:docs_manager/frontend/components/widgets/widget_preview.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:docs_manager/others/constants.dart' as constants;
import 'dart:core';

class ContentCategoryCreate extends StatefulWidget {
  final Alert a;
  final ReadDB readDB;
  final CreateDB createDB;
  const ContentCategoryCreate(this.a, this.readDB, this.createDB, {super.key});

  @override
  State<ContentCategoryCreate> createState() => ContentCategoryCreateState();
}

class ContentCategoryCreateState extends State<ContentCategoryCreate> {
  final ImagePicker picker = ImagePicker();
  bool hasUploaded = false;
  bool doesExist = false;
  XFile? imageGallery;
  TextEditingController catNameController = TextEditingController();
  Widget widgetChanging = constants.defaultImg;
  @override
  void initState() {
    widget.readDB
        .checkElementExistDB(catNameController.text, "categories", setBool);

    super.initState();
  }

  @override
  void dispose() {
    catNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Align(
            alignment: const AlignmentDirectional(0, -0.9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //title 1
                      const TitleText('Category name:', Colors.black),
                      //input 1
                      InputField(catNameController, true),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //title 2
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child:
                          TitleText('Select a category image:', Colors.black),
                    ),

                    //button upload 1
                    MyButton('Upload', setPhotoFromGallery),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          hasUploaded
                              ? DocumentPreview(
                                  Image(
                                    image: XFileImage(imageGallery!),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  MediaQuery.of(context).size.width * 0.9,
                                  removeImage,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: constants.mainBackColor),
                                  ),
                                  child: widgetChanging,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
          imageQuality: constants.imageQuality * 2);
      setState(
        () {
          widgetChanging = Image(
            image: XFileImage(imageGallery!),
            fit: BoxFit.fill,
          );
          hasUploaded = true;
        },
      );
    } catch (e) {
      widget.a.onErrorImage(context);
    }
  }

//===================================================================================
// Submit category to db if everything is correct
  onSubmit() {
    if (catNameController.text == "" || catNameController.text == " ") {
      widget.a.onErrorText(context);
    } else if (doesExist) {
      widget.a.onErrorElementExisting(context, "Category");
    } else if (imageGallery != null) {
      try {
        String ext = imageGallery!.name.toString().split(".")[1];
        String saveName = "${catNameController.text}.$ext";
        widget.createDB.createCategoryDB(catNameController.text, saveName);
        StreamSubscription listenLoading = widget.createDB.loadFileToStorage(
            imageGallery!.path, catNameController.text, saveName, 'categories');
        widget.a.onLoad(context);
        Future.delayed(const Duration(seconds: 3),
            () => widget.a.onSuccess(context, '/categories'));
        listenLoading.cancel();
        catNameController.dispose();
      } catch (e) {
        print("Error: $e");
      }
    } else {
      widget.a.onErrorImage(context);
    }
  }

  //===================================================================================
  // set if category exists
  setBool(bool b) {
    catNameController.addListener(() {
      setState(() {
        doesExist = b;
      });
    });
  }

  //===================================================================================
  // Submit category to db if everything is correct
  removeImage(Widget w) {
    setState(() {
      widgetChanging = constants.defaultImg;
      hasUploaded = false;
      imageGallery = null;
    });
  }

  //===================================================================================
}
