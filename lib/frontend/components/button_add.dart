import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ButtonAdd extends StatelessWidget {
  final String linkNav;
  final BuildContext pageContext;
  final IconData icon;

  /// Creates an 'add button' that redirect you to [link] creation page
  ///
  /// 1-actual screen context
  ///
  /// 2-link to move
  ///
  const ButtonAdd(this.pageContext, this.linkNav, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 30, 30),
        child: FloatingActionButton(
          heroTag: icon.toString(),
          onPressed: () {
            Navigator.pushNamed(
              pageContext,
              linkNav,
            );
          },
          backgroundColor: constants.mainBackColor,
          elevation: 8,
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
