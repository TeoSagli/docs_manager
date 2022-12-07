import 'package:docs_manager/others/constants.dart' as constants;
import 'package:flutter/material.dart';
//import 'package:project_navigation/components/icon_box.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isVisibleBackButton;
  BuildContext backContext;

  ///My custom AppBar:
  ///
  ///1-set title name.
  ///
  ///2-set if back button is visible
  ///
  ///3-set context to recall with back button
  ///
  MyAppBar(this.title, this.isVisibleBackButton, this.backContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: constants.mainBackColor,
        title: Text(title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            )),
        elevation: 2,
        leading: Visibility(
          maintainSemantics: isVisibleBackButton,
          maintainInteractivity: isVisibleBackButton,
          maintainAnimation: isVisibleBackButton,
          maintainSize: isVisibleBackButton,
          maintainState: isVisibleBackButton,
          visible: isVisibleBackButton,
          child: IconButton(
            iconSize: 40,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(backContext);
              backContext = context;
            },
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
