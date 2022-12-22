import 'package:flutter/material.dart';
import 'package:docs_manager/frontend/components/button_icon_function.dart';

class ButtonsUploadPhotoes extends StatelessWidget {
  final dynamic setPhotoFromCamera;
  final dynamic setPhotoFromGallery;
  const ButtonsUploadPhotoes(this.setPhotoFromCamera, this.setPhotoFromGallery,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyButtonIcon('CAMERA', setPhotoFromCamera, Icons.photo_camera),
        MyButtonIcon('GALLERY', setPhotoFromGallery, Icons.image),
        const MyButtonIcon('PDF, TXT....', {}, Icons.picture_as_pdf),
      ],
    );
  }
  //===================================================================================

}
