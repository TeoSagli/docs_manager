import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class DocumentPreview extends StatelessWidget {
  final dynamic removeImage;
  final Image loadedImage;
  final String? pathImage;
  final String? nameImage;
  final double cardSize;

  /// A preview image card with remove button:
  ///
  /// 1-image loaded
  ///
  /// 2-height and width fixed
  ///
  /// 3-remove image method
  ///
  /// 4-path image
  ///
  const DocumentPreview(this.loadedImage, this.cardSize, this.removeImage,
      {this.pathImage, this.nameImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
      child: Container(
        width: cardSize,
        height: cardSize,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x33000000),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
            topLeft: Radius.zero,
            topRight: Radius.zero,
          ),
          border: Border.all(
            color: constants.mainBackColor,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: loadedImage,
            ),
            InkWell(
              onTap: () => removeImage(this),
              child: Container(
                width: double.infinity,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: const Text(
                  'Remove',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
