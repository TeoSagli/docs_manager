import 'package:cross_file_image/cross_file_image.dart';
import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_rounded.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:docs_manager/others/constants.dart' as constants;

import '../../components/image_network.dart';

class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  _CategoryCreateWidgetState createState() => _CategoryCreateWidgetState();
}

class _CategoryCreateWidgetState extends State<CategoryCreatePage> {
  late final ImagePicker picker = ImagePicker();
  XFile? imageGallery;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Widget widgetChanging = const ImageFromNetwork(
      Colors.white,
      'https://media.istockphoto.com/id/1206044836/vector/preview-stamp-preview-round-vintage-grunge-sign-preview.jpg?s=612x612&w=0&k=20&c=SSZ0NLA7Bsv3Zlq_9DhalidL0Fc2ofhF7BCq2vjcNwc=',
      200,
      200);

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
                              TitleText('Category name:', Colors.black),
                              //input 1
                              const InputField(),
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
                              TitleText(
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
        },
      );
    } catch (e) {
      print("Error" + e.toString());
      setState(() {
        widgetChanging = const Center(
          child: Text(
            "Error uploading!",
            style: TextStyle(color: Colors.redAccent, fontSize: 50),
          ),
        );
      });
    }
  }

  onSubmit() {}
}
