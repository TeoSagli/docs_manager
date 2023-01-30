import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/category_card.dart';
import 'package:docs_manager/frontend/components/widgets/category_overview_card.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';
import 'package:docs_manager/frontend/components/widgets/list_card.dart';
import 'package:docs_manager/frontend/components/widgets/wallet_card.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:pdfx/pdfx.dart';
import 'models/category.dart';
import 'package:path_provider/path_provider.dart';

class ReadDB {
//===================================================================================
  /// Read category [catName] images from Firebase Storage
  readImageCategoryStorage(String catName, dynamic setCard) async {
    var key = userRefDB();
    var userPath = "users/$key";
    final storageRef = FirebaseStorage.instance.ref("$userPath/categories");
    // print(await storageRef.child("Pictures.png").getDownloadURL());
    // print("bro $catName");
    final catRef = storageRef.child(catName);

    try {
      Uint8List? data = await catRef.getData();
      setCard(data);
      // Data for "images/island.jpg" is returned, use this as needed.
    } on FirebaseException catch (e) {
      // Handle any errors.
      print("Error $e!");
    }
  }

//===================================================================================
  /// Read file image at index i of file [fileName] from Firebase Storage
  readImageFileStorage(
      int i,
      String catName,
      String fileName,
      String ext,
      Widget cardImage,
      BuildContext context,
      bool isFullHeigth,
      dynamic setImage) async {
    var key = userRefDB();
    var userPath = "users/$key";
    final storageRef = FirebaseStorage.instance.ref("$userPath/files/$catName");
    final fileRef = storageRef.child("$fileName$i.$ext");
    try {
      fileRef.getData().then((value) async {
        double widthValue =
            isFullHeigth ? min(MediaQuery.of(context).size.width, 500) : 160;
        double heightValue =
            MediaQuery.of(context).size.aspectRatio * widthValue;
        if (ext != 'pdf') {
          cardImage = Image.memory(
            value!,
            width: widthValue,
            height: heightValue,
            cacheHeight: 800,
            filterQuality: FilterQuality.low,
            fit: BoxFit.cover,
          );
        } else {
          cardImage = Image.memory(
            await imageFromPdfFile(value!),
            width: widthValue,
            height: heightValue,
            cacheHeight: 800,
            filterQuality: FilterQuality.low,
            fit: BoxFit.cover,
          );
        }
        setImage(cardImage);
      });
    } on FirebaseException catch (e) {
      // Handle any errors.
      setImage(constants.defaultImg);
      print("Error $e!");
    } catch (e) {
      setImage(constants.defaultImg);
    }
  }
//===================================================================================
  /// Read file PDF from Firebase Storage

  readFileFromNameStorage(
    String i,
    String catName,
    String fileName,
    dynamic setFile,
  ) async {
    var key = userRefDB();
    var userPath = "users/$key";
    final storageRef = FirebaseStorage.instance.ref("$userPath/files/$catName");
    final fileRef = storageRef.child("$fileName$i.pdf");
    try {
      Uint8List data = (await fileRef.getData())!;
      setFile(data, true);
    } on FirebaseException catch (e) {
      // Handle any errors.
      print("Error $e!");
    }
    return File("");
  }
//===================================================================================
  /// Read file PDF from Firebase Storage

  Future<File> readGenericFileFromNameStorage(
    String i,
    String catName,
    String extension,
    String fileName,
  ) async {
    var key = userRefDB();
    var userPath = "users/$key";
    Reference storageRef =
        FirebaseStorage.instance.ref("$userPath/files/$catName");
    Reference fileRef = storageRef.child("$fileName$i.$extension");
    try {
      Uint8List data = (await fileRef.getData())!;
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(data);

      return file;
    } on FirebaseException catch (e) {
      // Handle any errors.
      print("Error $e!");
      return File("");
    }
  }

//===================================================================================
  /// Read all categories infos from Firebase Database and create categories cards
  retrieveCategoriesDB(dynamic fulfillCard, dynamic moveToCategory,
      dynamic moveToEditCategory, dynamic removeCard) {
    var key = userRefDB();
    var userPath = "users/$key";
    return FirebaseDatabase.instance
        .ref("$userPath/categories")
        .onValue
        .listen((event) {
      List<Container> cards =
          List.generate(event.snapshot.children.length, (index) => Container());
      List<int> orders =
          List.generate(event.snapshot.children.length, ((index) => 0));
      for (var el in event.snapshot.children) {
        //el.value contenuto di category{path:..., nfiles:...}
        final data =
            Map<String, dynamic>.from(el.value as Map<Object?, Object?>);
        final cardCat = CategoryModel.fromRTDB(data);
        //el.key nome di category
        final cardName = el.key.toString();

        //insert card in order
        cards.insert(
            cardCat.order,
            Container(
              key: Key(cardCat.order.toString()),
              child: CategoryCard(
                  cardName,
                  cardCat,
                  moveToCategory,
                  moveToEditCategory,
                  removeCard,
                  readImageCategoryStorage,
                  Alert().onDelete),
            ));
        // TO FIX====================================
        orders.insert(cardCat.order, cardCat.order);
        if (cardCat.order < event.snapshot.children.length) {
          cards.removeAt(cardCat.order + 1);
          orders.removeAt(cardCat.order + 1);
        }
      }
      fulfillCard(cards, orders);
    });
  }

//===================================================================================
  /// Read all categories infos from Firebase Database and create overview cards
  void retrieveCategoryOverviewDB(dynamic fulfillCard, dynamic moveToCategory) {
    var key = userRefDB();
    var userPath = "users/$key";
    FirebaseDatabase.instance
        .ref("$userPath/categories")
        .onValue
        .listen((event) {
      List<Container> cards =
          List.generate(event.snapshot.children.length, (index) => Container());
      List<int> orders =
          List.generate(event.snapshot.children.length, ((index) => 0));
      for (var el in event.snapshot.children) {
        //el.value contenuto di category{path:..., nfiles:...}
        final data =
            Map<String, dynamic>.from(el.value as Map<Object?, Object?>);
        final cardCat = CategoryModel.fromRTDB(data);
        //el.key nome di category
        final cardName = el.key.toString();

        //insert card in order
        cards.insert(
            cardCat.order,
            Container(
              key: Key(cardCat.order.toString()),
              child: CategoryOverviewCard(
                  cardName, cardCat, moveToCategory, readImageCategoryStorage),
            ));
        // TO FIX====================================
        orders.insert(cardCat.order, cardCat.order);
        if (cardCat.order < event.snapshot.children.length) {
          cards.removeAt(cardCat.order + 1);
          orders.removeAt(cardCat.order + 1);
        }
      }
      fulfillCard(cards, orders);
    });
  }

//===================================================================================
  /// Read all files infos from Firebase Database and create files cards
  retrieveAllFilesDB(dynamic fulfillCard, dynamic moveToFile,
      dynamic moveToEditFile, dynamic removeCard, bool isFavPage) {
    var key = userRefDB();
    var userPath = "users/$key";
    FirebaseDatabase.instance.ref("$userPath/allFiles").onValue.listen((event) {
      int cardListSize = event.snapshot.children.length;

      List<FileCard> gridView = List.empty(growable: true);
      List<ListCard> listView = List.empty(growable: true);
      List<Widget> gridCards =
          List.generate(cardListSize, (index) => Container());
      List<Widget> listCards =
          List.generate(cardListSize, (index) => Container());
      for (var f in event.snapshot.children) {
        //el.value contenuto di category{path:..., nfiles:...}
        final data =
            Map<String, dynamic>.from(f.value as Map<Object?, Object?>);

        FileModel cardFile = FileModel.fromRTDB(data);
        if (!cardFile.isFavourite && isFavPage) continue;
        //el.key nome di file
        final cardName = f.key.toString();

        gridView.add(
          FileCard(
              cardName,
              cardFile,
              moveToFile,
              moveToEditFile,
              removeCard,
              readImageFileStorage,
              getColorCategoryDB,
              UpdateDB().updateFavouriteDB,
              Alert().onDeleteFile),
        );
        listView.add(
          ListCard(
            cardName,
            cardFile,
            moveToFile,
            moveToEditFile,
            removeCard,
            UpdateDB().updateFavouriteDB,
            Alert().onDeleteFile,
            ReadDB().readImageCategoryStorage,
            ReadDB().getCatModelFromCatNameDB,
          ),
        );
      }
      if (!isFavPage) {
        gridView.sort((a, b) {
          DateTime adate = DateTime.parse(a.file.dateUpload);
          DateTime bdate = DateTime.parse(b.file.dateUpload);
          return adate.compareTo(bdate);
        });
        listView.sort((a, b) {
          DateTime adate = DateTime.parse(a.file.dateUpload);
          DateTime bdate = DateTime.parse(b.file.dateUpload);
          return adate.compareTo(bdate);
        });
      }
      gridCards.clear();
      gridCards.addAll(gridView);
      listCards.clear();
      listCards.addAll(listView);
      fulfillCard(gridCards, listCards);
    });
  }

//===================================================================================
  /// Read all files infos from Firebase Database and create wallet cards
  retrieveAllExpirationFilesDB(dynamic fulfillCard, dynamic moveToFile) {
    var key = userRefDB();
    var userPath = "users/$key";
    return FirebaseDatabase.instance
        .ref("$userPath/files")
        .onValue
        .listen((event) {
      List<WalletCard> tempCards = List.empty(growable: true);

      for (var cat in event.snapshot.children) {
        for (var el in cat.children) {
          //el.value contenuto di category{path:..., nfiles:...}
          final data =
              Map<String, dynamic>.from(el.value as Map<Object?, Object?>);

          FileModel cardFile = FileModel.fromRTDB(data);

          if (cardFile.expiration.isEmpty) continue;

          //el.key nome di category
          final cardName = el.key.toString();

          //insert card in order
          tempCards.add(
            WalletCard(cardName, cardFile.expiration, cardFile, moveToFile,
                readImageFileStorage),
          );

          //   orders.insert(cardCat.order, cardCat.order);
          //   orders.removeAt(cardCat.order + 1);
        }
      }

      tempCards.sort((a, b) {
        DateTime adate = a.expiration;
        DateTime bdate = b.expiration;
        return adate.compareTo(bdate);
      });

      List<Widget> cards =
          List.generate(tempCards.length, (index) => Container());
      cards.clear();
      cards.addAll(tempCards);

      fulfillCard(cards);
    });
  }

//===================================================================================
  /// Read all files infos of category [catName] from Firebase Database and create files cards
  retrieveFilesFromCategoryDB(String catName, dynamic fulfillCard,
      dynamic moveToFile, dynamic moveToEditFile, dynamic removeCard, context) {
    var key = userRefDB();
    var userPath = "users/$key";
    return FirebaseDatabase.instance
        .ref("$userPath/files/$catName")
        .onValue
        .listen((event) {
      List<Widget> cardsGrid =
          List.generate(event.snapshot.children.length, (index) => Container());
      List<Widget> cardsList =
          List.generate(event.snapshot.children.length, (index) => Container());
      for (var el in event.snapshot.children) {
        //el.value contenuto di category{path:..., nfiles:...}
        final data =
            Map<String, dynamic>.from(el.value as Map<Object?, Object?>);

        FileModel cardFile = FileModel.fromRTDB(data);
        //el.key nome di category
        final cardName = el.key.toString();

        //insert card in order
        cardsGrid.add(
          FileCard(
              cardName,
              cardFile,
              moveToFile,
              moveToEditFile,
              removeCard,
              readImageFileStorage,
              getColorCategoryDB,
              UpdateDB().updateFavouriteDB,
              Alert().onDeleteFile),
        );
        cardsList.add(
          ListCard(
            cardName,
            cardFile,
            moveToFile,
            moveToEditFile,
            removeCard,
            UpdateDB().updateFavouriteDB,
            Alert().onDeleteFile,
            ReadDB().readImageCategoryStorage,
            ReadDB().getCatModelFromCatNameDB,
          ),
        );
      }
      fulfillCard(cardsGrid, cardsList);
    });
  }

//===================================================================================
  /// Read all categories names and fill dropdown menù
  retrieveCategoriesNamesDB(dynamic fillCategoriesNames) {
    var key = userRefDB();
    var userPath = "users/$key";
    return FirebaseDatabase.instance
        .ref("$userPath/categories")
        .onValue
        .listen((event) {
      List<String> list = [];
      for (var el in event.snapshot.children) {
        list.add(el.key.toString());
      }
      fillCategoriesNames(list);
    });
  }

//===================================================================================
  /// Read category [catName] color and set color in cards
  getColorCategoryDB(dynamic setColor, String catName) {
    var key = userRefDB();
    var userPath = "users/$key";
    return FirebaseDatabase.instance
        .ref("$userPath/categories/$catName")
        .onValue
        .listen((event) {
      final data = Map<String, dynamic>.from(
          event.snapshot.value as Map<Object?, Object?>);
      final cardCat = CategoryModel.fromRTDB(data);
      setColor(cardCat.colorValue);
    });
  }

//===================================================================================
  /// Read category [catName] data
  getCatModelFromCatNameDB(dynamic setCatPath, String catName) {
    var key = userRefDB();
    var userPath = "users/$key";
    return FirebaseDatabase.instance
        .ref("$userPath/categories/$catName")
        .onValue
        .listen((event) {
      final data = Map<String, dynamic>.from(
          event.snapshot.value as Map<Object?, Object?>);
      final cardCat = CategoryModel.fromRTDB(data);
      setCatPath(cardCat);
    });
  }

//===================================================================================
  /// Read file [fileName] data
  retrieveFileDataFromFileNameDB(String fileName, dynamic setFileData) {
    var key = userRefDB();
    var userPath = "users/$key";
    return FirebaseDatabase.instance
        .ref("$userPath/allFiles/$fileName")
        .onValue
        .listen((event) {
      final data = Map<String, dynamic>.from(
          event.snapshot.value as Map<Object?, Object?>);

      FileModel cardFile = FileModel.fromRTDB(data);
      setFileData(cardFile);
    });
  }

//===================================================================================
  /// Read current user id
  userRefDB() {
    if (FirebaseAuth.instance.currentUser == null) {
      return "";
    } else {
      return FirebaseAuth.instance.currentUser!.uid;
    }
  }

//===================================================================================
  /// Read first PDF page from PDF [data]
  Future<Uint8List> imageFromPdfFile(Uint8List data) async {
    PdfDocument document = await PdfDocument.openData(data);
    PdfPage page = await document.getPage(1);
    PdfPageImage? pageImage =
        await page.render(width: page.width, height: page.height);
    return pageImage!.bytes;
  }

//===================================================================================
  /// Read [elName] and check if element exixts in db
  checkElementExistDB(String elName, String ref, dynamic setExist) {
    var key = userRefDB();
    var userPath = "users/$key";
    FirebaseDatabase.instance.ref("$userPath/$ref").onValue.listen((event) {
      List<String> list = [];
      for (var el in event.snapshot.children) {
        list.add(el.key.toString());
      }
      // print("Elem name: $elName - Ref: $ref - Bool: ${list.contains(elName)}");
      setExist(list.contains(elName));
    });
  }
//===================================================================================
}
