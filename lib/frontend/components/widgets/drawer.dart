import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyDrawer extends StatelessWidget {
  final dynamic onAccountStatus;
  final dynamic onSettings;
  const MyDrawer(this.onAccountStatus, this.onSettings, {super.key});

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
                  const Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'DocuManager',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              )),
          ListTile(
            title: TextButton(
              key: const Key("account"),
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
                  Expanded(
                    child: Icon(Icons.account_circle, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      'Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              key: const Key("settings"),
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
