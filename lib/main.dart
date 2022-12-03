import 'package:flutter/material.dart';
import 'frontend/pages/categories/categories.dart';
import 'frontend/pages/categories/category_create.dart';
import 'frontend/pages/expirations.dart';
import 'frontend/pages/categories/category_view.dart';
import 'frontend/pages/favourites.dart';
import 'frontend/pages/home.dart';
import 'frontend/pages/files/file_view.dart';
import 'frontend/pages/unknown.dart';
import 'frontend/pages/files/file_create.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const HomePage());
        }
        var uri = Uri.parse(settings.name.toString());

        switch (uri.pathSegments.length) {
          case 1:
            //=============PATH FORMAT: /first====================
            switch (uri.pathSegments.first) {
              case 'categories':
                return MaterialPageRoute(
                    builder: (context) => const CategoriesPage());
              case 'expirations':
                return MaterialPageRoute(
                    builder: (context) => const ExpirationsPage());
              case 'favourites':
                return MaterialPageRoute(
                    builder: (context) => const FavouritesPage());
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
                        builder: (context) => const FileCreatePage());
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
                    var id = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) => CategoryViewPage(id: id));
                  default:
                    break;
                }
                break;
              case 'files':
                switch (uri.pathSegments[1]) {
                  case 'view':
                    var id = uri.pathSegments[2];
                    return MaterialPageRoute(
                        builder: (context) => FileViewPage(id: id));
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
      },
    );
  }
}
