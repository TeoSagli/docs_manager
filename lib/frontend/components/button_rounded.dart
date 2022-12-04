import 'package:docs_manager/frontend/components/image_network.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';

class MyButton extends StatefulWidget {
  dynamic function;
  String text;
  MyButton(this.text, this.function, {super.key});

  @override
  State<StatefulWidget> createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(constants.mainBackColor),
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
        onPressed: () => widget.function(),
        child: TitleText(widget.text, Colors.white),
      ),
    );
  }
}
