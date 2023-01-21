import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: constants.mainBackColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/LogoTransparentBig.png",
                    width: 50,
                    height: 50,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    'DocuManager',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
          ListTile(
            title: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll(constants.mainBackColor),
                elevation: const MaterialStatePropertyAll(1),
                shadowColor:
                    const MaterialStatePropertyAll(constants.mainBackColor),
                enableFeedback: true,
                side: const MaterialStatePropertyAll(
                  BorderSide(color: Colors.white, width: 0.25),
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
              ),
              onPressed: () => onAccountStatus(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.account_circle, color: Colors.white),
                  Text(
                    'Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll(constants.mainBackColor),
                elevation: const MaterialStatePropertyAll(1),
                shadowColor:
                    const MaterialStatePropertyAll(constants.mainBackColor),
                enableFeedback: true,
                side: const MaterialStatePropertyAll(
                  BorderSide(color: Colors.white, width: 0.25),
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
              ),
              onPressed: () => onSettings(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.settings, color: Colors.white),
                  Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}