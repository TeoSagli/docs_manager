import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/handlers/handleLogin.dart';
import 'package:docs_manager/backend/handlers/handleRegistration.dart';
import 'package:docs_manager/backend/models/user.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/contentPages/content_favourites.dart';
import 'package:docs_manager/frontend/components/contentPages/content_home.dart';
import 'package:docs_manager/frontend/components/contentPages/content_register.dart';
import 'package:docs_manager/frontend/components/contentPages/content_wallet.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:docs_manager/frontend/pages/file_edit.dart';
import 'package:docs_manager/frontend/pages/login.dart';
import 'package:docs_manager/frontend/pages/view_pdf.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'frontend/components/contentPages/content_categories.dart';
import 'frontend/components/contentPages/content_login.dart';
import 'frontend/pages/categories.dart';
import 'frontend/pages/categories_edit.dart';
import 'frontend/pages/category_create.dart';
import 'frontend/pages/register.dart';
import 'frontend/pages/wallet.dart';
import 'frontend/pages/category_view.dart';
import 'frontend/pages/favourites.dart';
import 'frontend/pages/home.dart';
import 'frontend/pages/file_view.dart';
import 'frontend/pages/unknown.dart';
import 'frontend/pages/file_create.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: '6Ldf3dEjAAAAAMexYWBeMObNlGzCcpi5zF0DYr6l',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();

  const MyApp({super.key});
}

class MyAppState extends State<MyApp> {
  late HandleLogin handleLogin;
  late HandleRegistration handleRegister;
  late final MyDrawer myDrawer;
  late String pageName = "";
  @override
  void initState() {
    setState(() {
      handleLogin = HandleLogin(UserCredsModel("", ""));
      handleRegister = HandleRegistration(UserCredsModel("", ""));
      myDrawer = const MyDrawer(onAccountStatus, onSettings);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          if (isLogged()) {
            return MaterialPageRoute(
              builder: (context) => HomePage(
                const ContentHome(
                  retrieveAllFilesDB,
                  retrieveCategoryOverviewDB,
                  Navigator.pushNamed,
                  deleteFileDB,
                  deleteFileStorage,
                  onUpdateNFilesDB,
                ),
                getAppBar(0, 'Homepage', context),
                getBottomBar(0, context),
                myDrawer,
              ),
            );
          } else {
            return MaterialPageRoute(
                builder: (context) => LoginPage(
                      ContentLogin(
                          handleLogin.login,
                          context,
                          onErrorGeneric,
                          onErrorFirebase,
                          onLoginConfirmed,
                          Navigator.pushNamed),
                      getAppBar(2, 'Login', context),
                    ));
          }
        }
        var uri = Uri.parse(settings.name.toString());

        switch (uri.pathSegments.length) {
          case 1:
            //=============PATH FORMAT: /first====================
            switch (uri.pathSegments.first) {
              case 'categories':
                return MaterialPageRoute(
                  builder: (context) => CategoriesPage(
                    const ContentCategories(),
                    getAppBar(0, 'Homepage', context),
                    getBottomBar(1, context),
                    myDrawer,
                  ),
                );
              case 'wallet':
                return MaterialPageRoute(
                  builder: (context) => WalletPage(
                    const ContentWallet(),
                    getAppBar(0, 'Wallet', context),
                    getBottomBar(1, context),
                    myDrawer,
                  ),
                );
              case 'favourites':
                return MaterialPageRoute(
                  builder: (context) => FavouritesPage(
                    const ContentFavourites(),
                    getAppBar(0, 'Favourites', context),
                    getBottomBar(1, context),
                    myDrawer,
                  ),
                );
              case 'login':
                return MaterialPageRoute(
                  builder: (context) => LoginPage(
                    ContentLogin(handleLogin.login, context, onErrorGeneric,
                        onErrorFirebase, onLoginConfirmed, Navigator.pushNamed),
                    getAppBar(2, 'Login', context),
                  ),
                );
              case 'register':
                return MaterialPageRoute(
                  builder: (context) => RegisterPage(
                    ContentRegister(handleRegister.register,
                        handleRegister.setUser, context),
                    getAppBar(3, "Register", context),
                  ),
                );
              default:
                break;
            }
            break;
          case 2:
            //=============PATH FORMAT: /first/second=============
            switch (uri.pathSegments.first) {
              case 'categories':
                switch (uri.pathSegments[1]) {
                  case 'create':
                    return MaterialPageRoute(
                        builder: (context) => const CategoryCreatePage());
                  default:
                    break;
                }
                break;
              case 'files':
                switch (uri.pathSegments[1]) {
                  case 'create':
                    return MaterialPageRoute(
                        builder: (context) => const FileCreatePage(
                              catSelected: "",
                            ));
                  default:
                    break;
                }
            }
            break;
          case 3:
            //=============PATH FORMAT: /first/second/third=======
            switch (uri.pathSegments.first) {
              case 'categories':
                switch (uri.pathSegments[1]) {
                  case 'view':
                    var catName = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) =>
                            CategoryViewPage(catName: catName));
                  case 'edit':
                    var catName = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) =>
                            CategoryEditPage(catName: catName));
                  default:
                    break;
                }
                break;
              case 'files':
                switch (uri.pathSegments[1]) {
                  case 'view':
                    var fileName = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) => FileViewPage(fileName: fileName));
                  case 'edit':
                    var fileName = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) => FileEditPage(fileName: fileName));
                  case 'create':
                    var catSelected = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) =>
                            FileCreatePage(catSelected: catSelected));
                  default:
                    break;
                }
            }
            break;
          case 4:
            //=============PATH FORMAT: /first/second/third/fourth=======
            switch (uri.pathSegments.first) {
              case 'files':
                {
                  var fileName = uri.pathSegments[1];
                  var catName = uri.pathSegments[2];
                  var pdfIndex = uri.pathSegments[3];
                  return MaterialPageRoute(
                      builder: (context) =>
                          PdfShow(fileName, catName, pdfIndex));
                }
            }
            break;
          default:
            //=============UNKNOWN PATH===========================
            return MaterialPageRoute(builder: (context) => const UnknownPage());
        }
        return null;
      },
    );
  }

  bool isLogged() {
    return FirebaseAuth.instance.currentUser != null;
  }

  MyAppBar getAppBar(int mode, name, context) {
    switch (mode) {
      // type 0 has button home
      case 0:
        return MyAppBar(name, false, context, true, Navigator.pop,
            Navigator.pushNamed, updateUserLogutStatus);
      // type 1 has button back
      case 1:
        return MyAppBar(name, true, context, true, Navigator.pop,
            Navigator.pushNamed, updateUserLogutStatus);
      // type 2 has button home while not logged
      case 2:
        return MyAppBar(name, false, context, false, Navigator.pop,
            Navigator.pushNamed, updateUserLogutStatus);
      // type 3 has button back while not logged
      case 3:
        return MyAppBar(name, true, context, false, Navigator.pop,
            Navigator.pushNamed, updateUserLogutStatus);
      default:
        return MyAppBar(name, false, context, true, Navigator.pop,
            Navigator.pushNamed, updateUserLogutStatus);
    }
  }

  MyBottomBar getBottomBar(int mode, context) {
    return MyBottomBar(context, mode, Navigator.pushNamed);
  }
}
