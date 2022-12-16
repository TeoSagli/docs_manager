import 'dart:async';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/backend/category_create_db.dart';
import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/image_network.dart';
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
  late TextEditingController textController1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Widget widgetChanging = const ImageFromNetwork(
      Colors.white,
      'https://media.istockphoto.com/id/1206044836/vector/preview-stamp-preview-round-vintage-grunge-sign-preview.jpg?s=612x612&w=0&k=20&c=SSZ0NLA7Bsv3Zlq_9DhalidL0Fc2ofhF7BCq2vjcNwc=',
      150,
      150);
  @override
  void initState() {
    textController1 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController1.dispose();
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
                          InputField(textController1),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //title 2
                          const TitleText(
                              'Select a category image:', Colors.black),
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
                                        widgetChanging, 200, removeImage)
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
      imageGallery = await picker.pickImage(source: ImageSource.gallery);
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
    if (textController1.text == "" || textController1.text == " ") {
      onErrorText(context);
    } else if (imageGallery != null) {
      try {
        String ext = imageGallery!.name.toString().split(".")[1];
        String saveName = "${textController1.text}.$ext";
        createCategory(textController1.text, saveName);
        StreamSubscription listenLoading =
            loadFileToStorage(imageGallery, textController1.text, saveName);
        onSuccess(context);
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
  removeImage() {
    setState(() {
      print("Fra sto qua");
      widgetChanging = const ImageFromNetwork(
          Colors.white,
          'https://media.istockphoto.com/id/1206044836/vector/preview-stamp-preview-round-vintage-grunge-sign-preview.jpg?s=612x612&w=0&k=20&c=SSZ0NLA7Bsv3Zlq_9DhalidL0Fc2ofhF7BCq2vjcNwc=',
          200,
          200);
      hasUploaded = false;
      imageGallery = null;
    });
  }
  //===================================================================================

}
