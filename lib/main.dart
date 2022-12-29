import 'package:docs_manager/frontend/pages/file_edit.dart';
import 'package:docs_manager/frontend/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          if (isLogged()) {
            return MaterialPageRoute(builder: (context) => const HomePage());
          } else {
            return MaterialPageRoute(builder: (context) => const LoginPage());
          }
        }
        var uri = Uri.parse(settings.name.toString());

        switch (uri.pathSegments.length) {
          case 1:
            //=============PATH FORMAT: /first====================
            switch (uri.pathSegments.first) {
              case 'categories':
                return MaterialPageRoute(
                    builder: (context) => const CategoriesPage());
              case 'wallet':
                return MaterialPageRoute(
                    builder: (context) => const WalletPage());
              case 'favourites':
                return MaterialPageRoute(
                    builder: (context) => const FavouritesPage());
              case 'login':
                return MaterialPageRoute(
                    builder: (context) => const LoginPage());
              case 'register':
                return MaterialPageRoute(
                    builder: (context) => const RegisterPage());
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
                break;
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
}
