import 'package:flutter/material.dart';

class ImageFromNetwork extends StatelessWidget {
  final Color backgroundCol;
  final String imgLink;
  final double width;
  final double height;

  /// Put an image from the web
  ///
  /// 1-set background color
  ///
  /// 2-set img link
  ///
  /// 3-set width
  ///
  /// 4-set height
  ///
  const ImageFromNetwork(
      this.backgroundCol, this.imgLink, this.width, this.height,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundCol,
        image: DecorationImage(
          fit: BoxFit.scaleDown,
          image: Image.network(
            imgLink,
          ).image,
        ),
      ),
    );
  }
}
