import 'dart:async';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:docs_manager/frontend/components/widget_preview.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:docs_manager/others/constants.dart' as constants;
import 'dart:core';

class ContentCategoryEdit extends StatefulWidget {
  String catName;
  ContentCategoryEdit(this.catName, {super.key});

  @override
  State<ContentCategoryEdit> createState() => ContentCategoryEditState();
}

class ContentCategoryEditState extends State<ContentCategoryEdit> {
  final ImagePicker picker = ImagePicker();
  bool hasUploaded = false;
  bool isAlreadyUpdated = true;
  XFile? imageGallery;
  late StreamSubscription listenPath;
  late TextEditingController catNameController;
  Widget widgetChanging = constants.defaultImg;
  CategoryModel catModel =
      CategoryModel(path: "", nfiles: 0, colorValue: 0, order: 0);
  @override
  void initState() {
    setState(() {
      imageGallery = null;
      catNameController = TextEditingController(text: widget.catName);
      listenPath = getCatModelFromCatNameDB(setCatModel, widget.catName);
    });

    super.initState();
  }

  @override
  void dispose() {
    listenPath.cancel();
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
            child: MyButton('Edit', onEdit),
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
            width: MediaQuery.of(context).size.width * 0.9,
            fit: BoxFit.fill,
          );
          hasUploaded = true;
          isAlreadyUpdated = false;
        },
      );
    } catch (e) {
      onErrorImage(context);
    }
  }

//===================================================================================
// Edit category to db if everything is correct
  onEdit() {
    // else if (!await isCategoryNew(textController1!.text)) {
    // onErrorCategoryExisting();}
    if (catNameController.text == "" || catNameController.text == " ") {
      onErrorText(context);
    } else if (imageGallery != null && !isAlreadyUpdated) {
      try {
        //delete old file version
        if (catNameController.text != widget.catName) {
          deleteCategoryDB(widget.catName);
        }

        deleteCategoryStorage(catModel.path, widget.catName);
        updateOrderDB(catModel.order, widget.catName);
        String ext = imageGallery!.name.toString().split(".")[1];
        String saveName = "${catNameController.text}.$ext";

        loadFileToStorage(
            imageGallery!.path, catNameController.text, saveName, 'categories');
        setState(() {
          catModel.path = saveName;
        });
        updateCategoryDB(catNameController.text, catModel);
        onSuccess(context, '/categories');
      } catch (e) {
        print("Error: $e");
      }
    } else if (isAlreadyUpdated) {
      try {
        if (catNameController.text != widget.catName) {
          deleteCategoryDB(widget.catName);
          updateCategoryDB(catNameController.text, catModel);
        }
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
  removeImage(Widget w) {
    setState(() {
      widgetChanging = constants.defaultImg;
      hasUploaded = false;
      imageGallery = null;
    });
  }

  //===================================================================================
  setCard(file) {
    setState(() {
      widgetChanging = Image.memory(
        file,
        width: MediaQuery.of(context).size.width * 0.9,
        fit: BoxFit.fill,
      );
    });
  }

  //===================================================================================
  setCatModel(CategoryModel c) {
    setState(() {
      catModel = c;
    });
    readImageCategoryStorage(catModel.path, setCard);
    listenPath.cancel();
  }
  //===================================================================================
}
