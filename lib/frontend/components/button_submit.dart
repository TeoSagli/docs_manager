import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ButtonSubmit extends StatelessWidget {
  final BuildContext pageContext;

  Function behaviour;

  /// Creates a 'submit button' that redirect you to [link] creation page
  ///
  /// 1-behaviour when submit
  ///
  ///
  ButtonSubmit(this.pageContext, this.behaviour, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
          onPressed: () => behaviour(context),
          child: const Text(
            "Confirm",
            style: TextStyle(
                backgroundColor: constants.mainBackColor, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
