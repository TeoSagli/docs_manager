import 'package:docs_manager/backend/google_integration.dart';
import 'package:docs_manager/backend/handlers/handleLogin.dart';
import 'package:docs_manager/backend/handlers/handleRegistration.dart';
import 'package:docs_manager/backend/models/user.dart';
import 'package:docs_manager/backend/operationsDB.dart';
import 'package:docs_manager/frontend/components/contentPages/content_favourites.dart';
import 'package:docs_manager/frontend/components/contentPages/content_home.dart';
import 'package:docs_manager/frontend/components/contentPages/content_pdf_show.dart';
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
import 'frontend/components/contentPages/content_category_create.dart';
import 'frontend/components/contentPages/content_category_edit.dart';
import 'frontend/components/contentPages/content_category_view.dart';
import 'frontend/components/contentPages/content_file_create.dart';
import 'frontend/components/contentPages/content_file_edit.dart';
import 'frontend/components/contentPages/content_file_view.dart';
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

class MyAppState extends State<MyApp> with OperationsDB {
  late HandleLogin handleLogin;
  late HandleRegistration handleRegister;
  late final MyDrawer myDrawer;
  late String pageName = "";
  late Alert alertClass;

  late GoogleManager googleManager;
  @override
  void initState() {
    setState(() {
      alertClass = Alert();
      googleManager = GoogleManager();
      handleLogin = HandleLogin(UserCredsModel("", ""));
      handleRegister = HandleRegistration(UserCredsModel("", ""));
      myDrawer = MyDrawer(alertClass);
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
                ContentHome(
                  readDB,
                  deleteDB,
                  updateDB,
                  alertClass,
                ),
                getAppBar(0, 'Homepage', context),
                getBottomBar(0, context),
                myDrawer,
              ),
            );
          } else {
            return MaterialPageRoute(
                builder: (context) => LoginPage(
                      ContentLogin(handleLogin.login, context, alertClass,
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
                    ContentCategories(
                      readDB.retrieveCategoriesDB,
                      updateDB.updateOrderDB,
                      deleteDB.deleteCategoryDB,
                      deleteDB.deleteCategoryStorage,
                      Navigator.pushNamed,
                    ),
                    getAppBar(0, 'Categories', context),
                    getBottomBar(2, context),
                    myDrawer,
                  ),
                );
              case 'wallet':
                return MaterialPageRoute(
                  builder: (context) => WalletPage(
                    ContentWallet(readDB.retrieveAllExpirationFilesDB,
                        Navigator.pushNamed),
                    getAppBar(0, 'Wallet', context),
                    getBottomBar(1, context),
                    myDrawer,
                  ),
                );
              case 'favourites':
                return MaterialPageRoute(
                  builder: (context) => FavouritesPage(
                    ContentFavourites(
                        readDB.retrieveAllFilesDB,
                        deleteDB.deleteFileDB,
                        deleteDB.deleteFileStorage,
                        updateDB.onUpdateNFilesDB,
                        Navigator.pushNamed),
                    getAppBar(0, 'Favourites', context),
                    getBottomBar(3, context),
                    myDrawer,
                  ),
                );
              case 'login':
                return MaterialPageRoute(
                  builder: (context) => LoginPage(
                    ContentLogin(handleLogin.login, context, alertClass,
                        Navigator.pushNamed),
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
                        builder: (context) => CategoryCreatePage(
                              ContentCategoryCreate(
                                  alertClass, readDB, createDB),
                              getAppBar(1, "Category creation", context),
                              myDrawer,
                            ));
                  default:
                    break;
                }
                break;
              case 'files':
                switch (uri.pathSegments[1]) {
                  case 'create':
                    return MaterialPageRoute(
                        builder: (context) => FileCreatePage(
                              ContentFileCreate(
                                  "",
                                  readDB.checkElementExistDB,
                                  readDB.retrieveCategoriesNamesDB,
                                  createDB.createFile,
                                  createDB.loadFileToStorage,
                                  updateDB.onUpdateNFilesDB,
                                  alertClass),
                              getAppBar(1, "File creation", context),
                              myDrawer,
                              "",
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
                        builder: (context) => CategoryViewPage(
                            ContentCategoryView(catName, readDB, deleteDB,
                                updateDB, alertClass),
                            getAppBar(1, "View category $catName", context),
                            myDrawer,
                            catName: catName));
                  case 'edit':
                    var catName = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) => CategoryEditPage(
                            ContentCategoryEdit(catName, readDB, createDB,
                                updateDB, deleteDB, alertClass),
                            getAppBar(1, "Editing category $catName", context),
                            myDrawer,
                            catName: catName));
                  default:
                    break;
                }
                break;
              case 'files':
                switch (uri.pathSegments[1]) {
                  case 'view':
                    var fileName = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) => FileViewPage(
                            ContentFileView(fileName, readDB, updateDB,
                                deleteDB, googleManager, alertClass),
                            getAppBar(1, "View file $fileName", context),
                            myDrawer,
                            fileName: fileName));
                  case 'edit':
                    var fileName = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) => FileEditPage(
                            ContentFileEdit(fileName, readDB, createDB,
                                updateDB, deleteDB, alertClass),
                            getAppBar(1, 'Edit file $fileName', context),
                            myDrawer,
                            fileName: fileName));
                  case 'create':
                    var catSelected = uri.pathSegments[2];
                    return MaterialPageRoute(
                      builder: (context) => FileCreatePage(
                        ContentFileCreate(
                            catSelected,
                            readDB.checkElementExistDB,
                            readDB.retrieveCategoriesNamesDB,
                            createDB.createFile,
                            createDB.loadFileToStorage,
                            updateDB.onUpdateNFilesDB,
                            alertClass),
                        getAppBar(1, "File creation", context),
                        myDrawer,
                        catSelected,
                      ),
                    );
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
                    builder: (context) => PdfShow(
                        ContentPdfShow(fileName, catName, pdfIndex,
                            readDB.readFileFromNameStorage),
                        getAppBar(1, 'View pdf N° $pdfIndex', context),
                        myDrawer),
                  );
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
            Navigator.pushNamed, updateDB.updateUserLogutStatus);
      // type 1 has button back
      case 1:
        return MyAppBar(name, true, context, true, Navigator.pop,
            Navigator.pushNamed, updateDB.updateUserLogutStatus);
      // type 2 has button home while not logged
      case 2:
        return MyAppBar(name, false, context, false, Navigator.pop,
            Navigator.pushNamed, updateDB.updateUserLogutStatus);
      // type 3 has button back while not logged
      case 3:
        return MyAppBar(name, true, context, false, Navigator.pop,
            Navigator.pushNamed, updateDB.updateUserLogutStatus);
      default:
        return MyAppBar(name, false, context, true, Navigator.pop,
            Navigator.pushNamed, updateDB.updateUserLogutStatus);
    }
  }

  MyBottomBar getBottomBar(int mode, context) {
    return MyBottomBar(context, mode, Navigator.pushNamed);
  }
}
