import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_rounded.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:docs_manager/others/constants.dart' as constants;

import '../../../backend/create_category.dart';
import '../../components/image_network.dart';

class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  CategoryCreateWidgetState createState() => CategoryCreateWidgetState();
}

class CategoryCreateWidgetState extends State<CategoryCreatePage> {
  late final ImagePicker picker = ImagePicker();
  XFile? imageGallery;
  TextEditingController? textController1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Widget widgetChanging = const ImageFromNetwork(
      Colors.white,
      'https://media.istockphoto.com/id/1206044836/vector/preview-stamp-preview-round-vintage-grunge-sign-preview.jpg?s=612x612&w=0&k=20&c=SSZ0NLA7Bsv3Zlq_9DhalidL0Fc2ofhF7BCq2vjcNwc=',
      200,
      200);
  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: MyBottomBar(context, 4),
      appBar: MyAppBar('Create a Category', true, context),
      body: Stack(
        children: [
          SafeArea(
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 30, 10, 0),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 0),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: constants.mainBackColor),
                                  ),
                                  child: widgetChanging,
                                ),
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
          ),
          //button submit 1

          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyButton('Submit', onSubmit),
              ]),
        ],
      ),
    );
  }

  setPhotoFromGallery() async {
    try {
      imageGallery = await picker.pickImage(source: ImageSource.gallery);
      setState(
        () {
          widgetChanging = Image(
            image: XFileImage(imageGallery!),
            width: 200,
            fit: BoxFit.scaleDown,
          );
          saveImage(imageGallery, imageGallery!.name);
        },
      );
    } catch (e) {
      setState(() {
        widgetChanging = Center(
          child: Text(
            "Error uploading! $e",
            style: const TextStyle(color: Colors.redAccent, fontSize: 50),
          ),
        );
      });
    }
  }

  saveImage(image, fileName) async {
/*
    const String path = 'assets/images/';
    await image.saveTo('$path/$fileName');*/
  }

  onSubmit() async {
    if (textController1 != null &&
        textController1?.text != "" &&
        textController1?.text != " " &&
        imageGallery != null) {
      createCategory(textController1?.text, imageGallery!.path.toString());
    } else {
      onError();
    }
  }

  onError() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
