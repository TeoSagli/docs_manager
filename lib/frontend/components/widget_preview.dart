import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:docs_manager/frontend/components/image_network.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class DocumentPreview extends StatefulWidget {
  dynamic removeImage;
  Widget loadedImage;
  final double cardWidth;

  DocumentPreview(this.loadedImage, this.cardWidth, this.removeImage,
      {super.key});

  @override
  State<StatefulWidget> createState() => DocumentPreviewState();
}

class DocumentPreviewState extends State<DocumentPreview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
      child: Container(
        width: widget.cardWidth,
        height: widget.cardWidth,
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
              child: widget.loadedImage,
            ),
            InkWell(
              onTap: () => widget.removeImage(),
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
