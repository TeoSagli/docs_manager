import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyButtonIcon extends StatelessWidget {
  final dynamic function;
  final String text;
  final IconData icon;

  ///My custom Button:
  ///
  ///1-set button text.
  ///
  ///2-set behaviour
  ///
  ///3-set icon
  ///

  const MyButtonIcon(this.text, this.function, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: constants.mainBackColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 0.1,
                color: constants.mainBackColor,
                offset: Offset(0, 2),
              )
            ],
            shape: BoxShape.circle,
          ),
          alignment: const AlignmentDirectional(0, 0),
          child: IconButton(
            onPressed: () => function(),
            icon: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: 'Poppins', fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }
}
