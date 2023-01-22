import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ButtonAdd extends StatelessWidget {
  final String linkNav;
  final BuildContext pageContext;
  final IconData icon;
  final String tooltip;
  final dynamic switchPage;

  /// Creates an 'add button' that redirect you to [link] creation page
  ///
  /// 1-actual screen context
  ///
  /// 2-link to move
  ///
  /// 3-icon to show
  ///
  /// 4-tooltip on long press
  ///
  /// 5-switch page
  ///
  const ButtonAdd(
      this.pageContext, this.linkNav, this.icon, this.tooltip, this.switchPage,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 30, 30),
        child: FloatingActionButton(
          tooltip: tooltip,
          heroTag: icon.toString(),
          onPressed: () => switchPage(
            pageContext,
            linkNav,
          ),
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
