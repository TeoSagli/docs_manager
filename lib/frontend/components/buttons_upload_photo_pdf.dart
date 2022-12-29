import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/button_icon_function.dart';

class ButtonsUploadPhotoes extends StatelessWidget {
  final dynamic setPhotoFromCamera;
  final dynamic setPhotoFromGallery;
  final dynamic setPhotoFromFile;
  const ButtonsUploadPhotoes(
      this.setPhotoFromCamera, this.setPhotoFromGallery, this.setPhotoFromFile,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyButtonIcon('CAMERA', setPhotoFromCamera, Icons.photo_camera),
        MyButtonIcon('GALLERY', setPhotoFromGallery, Icons.image),
        MyButtonIcon(
            'PDF', setPhotoFromFile, Icons.picture_as_pdf),
      ],
    );
  }
  //===================================================================================

}
