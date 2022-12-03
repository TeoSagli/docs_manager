import 'package:docs_manager/frontend/components/image_network.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';

class ButtonUploadImage extends StatefulWidget {
  const ButtonUploadImage({super.key});

  @override
  State<StatefulWidget> createState() => ButtonUploadImageState();
}

class ButtonUploadImageState extends State<ButtonUploadImage> {
  late final ImagePicker picker = ImagePicker();
  XFile? imageGallery;
  Widget widgetChanging = const ImageFromNetwork(
      Colors.white,
      'https://media.istockphoto.com/id/1206044836/vector/preview-stamp-preview-round-vintage-grunge-sign-preview.jpg?s=612x612&w=0&k=20&c=SSZ0NLA7Bsv3Zlq_9DhalidL0Fc2ofhF7BCq2vjcNwc=',
      200,
      200);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleText('Select a category image:', Colors.black),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(constants.mainBackColor),
                fixedSize: MaterialStateProperty.all(const Size(130, 40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              //   style: ButtonStyle( maximumSize: Size(width: 130,height: 40,)),
              onPressed: () => setPhotoFromGallery(context),
              child: TitleText('Upload', Colors.white),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: constants.mainBackColor),
              ),
              child: widgetChanging,
            ),
          ),
        ],
      ),
    );
  }

  setPhotoFromGallery(context) async {
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
      widgetChanging = const Center(
        child: Text(
          "Error uploading!",
          style: TextStyle(color: Colors.redAccent, fontSize: 50),
        ),
      );
    }
  }
}
