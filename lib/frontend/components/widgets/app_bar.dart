import 'package:docs_manager/others/constants.dart' as constants;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isVisibleBackButton;
  final BuildContext backContext;

  ///My custom AppBar:
  ///
  ///1-set title name.
  ///
  ///2-set if back button is visible
  ///
  ///3-set context to recall with back button
  ///
  const MyAppBar(this.title, this.isVisibleBackButton, this.backContext,
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
              iconSize: 40,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(backContext);
              },
            )
          : IconButton(
              tooltip: "Home",
              onPressed: () => Navigator.pushNamed(context, "/"),
              icon: Image.asset("assets/images/LogoTransparentBig.png"),
            ),
      actions: isLogged()
          ? [
              IconButton(
                tooltip: "Sign out",
                onPressed: () {
                  FirebaseAuth.instance.signOut().then(
                        (value) => Navigator.pushNamed(
                          context,
                          "/login",
                        ),
                      );
                },
                icon: const Icon(Icons.logout_rounded),
              )
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  bool isLogged() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
