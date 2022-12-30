import 'dart:async';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/category_card.dart';
import 'package:docs_manager/frontend/components/category_overview_card.dart';
import 'package:docs_manager/frontend/components/file_card.dart';
import 'package:docs_manager/frontend/components/wallet_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:pdfx/pdfx.dart';
import 'models/category.dart';

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
Future<Widget> readImageFileStorage(
    int i,
    String catName,
    String fileName,
    String ext,
    Widget cardImage,
    BuildContext context,
    bool isFullHeigth) async {
  var key = userRefDB();
  var userPath = "users/$key";
  final storageRef = FirebaseStorage.instance.ref("$userPath/files/$catName");
  final fileRef = storageRef.child("$fileName$i.$ext");
  try {
    return await fileRef.getData().then((value) async {
      if (ext != 'pdf') {
        cardImage = Image.memory(
          value!,
          width: isFullHeigth ? MediaQuery.of(context).size.width : 160,
          height: isFullHeigth ? null : 100,
          fit: BoxFit.cover,
        );
      } else {
        cardImage = Image.memory(
          await imageFromPdfFile(value!),
          width: isFullHeigth ? MediaQuery.of(context).size.width : 160,
          height: isFullHeigth ? null : 100,
          fit: BoxFit.cover,
        );
      }
      return cardImage;
    });
  } on FirebaseException catch (e) {
    // Handle any errors.
    print("Error $e!");
  }
  return constants.defaultImg;
}

//===================================================================================
/// Read all categories infos from Firebase Database and create categories cards
StreamSubscription retrieveCategoriesDB(dynamic fulfillCard,
    dynamic moveToCategory, dynamic moveToEditCategory, dynamic removeCard) {
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
      final data = Map<String, dynamic>.from(el.value as Map<Object?, Object?>);
      final cardCat = CategoryModel.fromRTDB(data);
      //el.key nome di category
      final cardName = el.key.toString();

      //insert card in order
      cards.insert(
          cardCat.order,
          Container(
            key: Key(cardCat.order.toString()),
            child: CategoryCard(cardName, cardCat, moveToCategory,
                moveToEditCategory, removeCard),
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
StreamSubscription retrieveCategoryOverviewDB(
    dynamic fulfillCard, dynamic moveToCategory) {
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
      final data = Map<String, dynamic>.from(el.value as Map<Object?, Object?>);
      final cardCat = CategoryModel.fromRTDB(data);
      //el.key nome di category
      final cardName = el.key.toString();

      //insert card in order
      cards.insert(
          cardCat.order,
          Container(
            key: Key(cardCat.order.toString()),
            child: CategoryOverviewCard(cardName, cardCat, moveToCategory),
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
StreamSubscription retrieveAllFilesDB(dynamic fulfillCard, dynamic moveToFile,
    dynamic moveToEditFile, dynamic removeCard, bool isFavPage) {
  var key = userRefDB();
  var userPath = "users/$key";
  return FirebaseDatabase.instance
      .ref("$userPath/allFiles")
      .onValue
      .listen((event) {
    int cardListSize = event.snapshot.children.length;

    List<Widget> cards = List.generate(cardListSize, (index) => Container());

    for (var f in event.snapshot.children) {
      //el.value contenuto di category{path:..., nfiles:...}
      final data = Map<String, dynamic>.from(f.value as Map<Object?, Object?>);

      FileModel cardFile = FileModel.fromRTDB(data);
      if (!cardFile.isFavourite && isFavPage) continue;
      //el.key nome di file
      final cardName = f.key.toString();

      //insert card in order
      cards.add(
        FileCard(cardName, cardFile, moveToFile, moveToEditFile, removeCard),
      );
    }
    fulfillCard(cards);
  });
}

//===================================================================================
/// Read all files infos from Firebase Database and create wallet cards
StreamSubscription retrieveAllExpirationFilesDB(dynamic fulfillCard,
    dynamic moveToFile, dynamic moveToEditFile, dynamic removeCard) {
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
              moveToEditFile, removeCard),
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

    cards.addAll(tempCards);

    fulfillCard(cards);
  });
}

//===================================================================================
/// Read all files infos of category [catName] from Firebase Database and create files cards
StreamSubscription retrieveFilesFromCategoryDB(
    String catName,
    dynamic fulfillCard,
    dynamic moveToFile,
    dynamic moveToEditFile,
    dynamic removeCard) {
  var key = userRefDB();
  var userPath = "users/$key";
  return FirebaseDatabase.instance
      .ref("$userPath/files/$catName")
      .onValue
      .listen((event) {
    List<Widget> cards =
        List.generate(event.snapshot.children.length, (index) => Container());
    for (var el in event.snapshot.children) {
      //el.value contenuto di category{path:..., nfiles:...}
      final data = Map<String, dynamic>.from(el.value as Map<Object?, Object?>);

      FileModel cardFile = FileModel.fromRTDB(data);
      //el.key nome di category
      final cardName = el.key.toString();

      //insert card in order
      cards.add(
        FileCard(cardName, cardFile, moveToFile, moveToEditFile, removeCard),
      );
    }
    fulfillCard(cards);
  });
}

//===================================================================================
/// Read all categories names and fill dropdown menù
StreamSubscription retrieveCategoriesNamesDB(dynamic fillCategoriesNames) {
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
StreamSubscription getColorCategoryDB(dynamic setColor, String catName) {
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
StreamSubscription getCatModelFromCatNameDB(
    dynamic setCatPath, String catName) {
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
