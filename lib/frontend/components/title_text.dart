import 'package:flutter/cupertino.dart';

class TitleText extends StatelessWidget {
  final String title;
  Color textColor;

  /// A simple centered text with:
  ///
  /// 1-title text
  ///
  /// 2-color text
  TitleText(this.title, this.textColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: textColor,
      ),
    );
  }
}
