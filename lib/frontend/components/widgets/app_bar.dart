import 'package:docs_manager/others/constants.dart' as constants;
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isVisibleBackButton;
  final bool isLogged;
  final BuildContext backContext;
  final dynamic func1;
  final dynamic func2;
  final dynamic func3;

  ///My custom AppBar:
  ///
  ///1-set title name.
  ///
  ///2-set if back button is visible
  ///
  ///3-set context to recall with back button
  ///
  ///4-navigate back method
  ///
  ///5-navigate to new page method
  ///
  ///6-sign out from DB method
  ///
  const MyAppBar(this.title, this.isVisibleBackButton, this.backContext,
      this.isLogged, this.func1, this.func2, this.func3,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: constants.mainBackColor,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 22,
        ),
      ),
      elevation: 2,
      leading: isVisibleBackButton
          ? IconButton(
              key: const Key("back"),
              iconSize: 40,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => func1(backContext),
            )
          : IconButton(
              key: const Key("home"),
              tooltip: "Home",
              onPressed: () => func2(context, "/"),
              icon: Image.asset("assets/images/LogoTransparentBig.png"),
            ),
      actions: isLogged
          ? [
              IconButton(
                key: const Key("logout"),
                tooltip: "Sign out",
                onPressed: () => func3(context),
                icon: const Icon(Icons.logout_rounded),
              )
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
