import 'dart:async';
import 'dart:io';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:docs_manager/frontend/components/widget_preview.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:docs_manager/others/constants.dart' as constants;
import 'dart:core';

class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  CategoryCreateWidgetState createState() => CategoryCreateWidgetState();
}

class CategoryCreateWidgetState extends State<CategoryCreatePage> {
  final ImagePicker picker = ImagePicker();
  bool hasUploaded = false;
  XFile? imageGallery;
  late TextEditingController catNameController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Widget widgetChanging = constants.defaultImg;
  @override
  void initState() {
    catNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    catNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      bottomNavigationBar: MyBottomBar(context, 4),
      appBar: MyAppBar('Category creation', true, context),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //title 1
                          const TitleText('Category name:', Colors.black),
                          //input 1
                          InputField(catNameController),
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
                          child: TitleText(
                              'Select a category image:', Colors.black),
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
                                      imageGallery!,
                                      MediaQuery.of(context).size.width * 0.9,
                                      removeImage)
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
      //button submit 1
    );
  }

//===================================================================================
// Upload photo from gallery and catch errors
  setPhotoFromGallery() async {
    try {
      imageGallery =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
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
      onErrorImage(context);
    }
  }

//===================================================================================
// Submit category to db if everything is correct
  onSubmit() {
    // else if (!await isCategoryNew(textController1!.text)) {
    // onErrorCategoryExisting();}
    if (catNameController.text == "" || catNameController.text == " ") {
      onErrorText(context);
    } else if (imageGallery != null) {
      try {
        String ext = imageGallery!.name.toString().split(".")[1];
        String saveName = "${catNameController.text}.$ext";
        createCategory(catNameController.text, saveName);
        StreamSubscription listenLoading = loadFileToStorage(
            imageGallery!.path, catNameController.text, saveName, 'categories');
        onSuccess(context, '/categories');
        listenLoading.cancel();
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
}
