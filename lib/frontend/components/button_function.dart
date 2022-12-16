import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyButton extends StatelessWidget {
  final dynamic function;
  final String text;

  ///My custom Button:
  ///
  ///1-set button text.
  ///
  ///2-set behaviour
  ///

  const MyButton(this.text, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: ElevatedButton(
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
        onPressed: () => function(),
        child: TitleText(text, Colors.white),
      ),
    );
  }
}
