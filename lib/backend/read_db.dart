import 'dart:async';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/category_card.dart';
import 'package:docs_manager/frontend/components/file_card.dart';
import 'package:docs_manager/frontend/components/wallet_card.dart';
import 'package:docs_manager/frontend/components/widget_preview.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/category.dart';

//===================================================================================
/// Load categories images from Firebase Storage
readImageCategoryStorage(String catName, dynamic setCard) async {
  final storageRef = FirebaseStorage.instance.ref("categories");
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
/// Load file image at index i from Firebase Storage
Future<Widget> readImageFileStorage(
    int i,
    String catName,
    String fileName,
    String ext,
    Widget cardImage,
    BuildContext context,
    bool isFullHeigth) async {
  final storageRef = FirebaseStorage.instance.ref("files/$catName");
  // print(await storageRef.child("Pictures.png").getDownloadURL());
  // print("bro $catName");
  final fileRef = storageRef.child("$fileName$i.$ext");
  try {
    return await fileRef.getData().then((value) => cardImage = Image.memory(
          value!,
          width: MediaQuery.of(context).size.width,
          height:
              isFullHeigth ? null : MediaQuery.of(context).size.height * 0.15,
          fit: BoxFit.cover,
        ));
  } on FirebaseException catch (e) {
    // Handle any errors.
    print("Error $e!");
  }
  return Image.asset("images/test.jpeg");
}

//===================================================================================
/// Load file image at index i from Firebase Storage
Future<Widget> readImageFileStorageEditFiles(int i, String catName,
    String fileName, String ext, Widget cardImage, BuildContext context) async {
  final storageRef = FirebaseStorage.instance.ref("files/$catName");
  // print(await storageRef.child("Pictures.png").getDownloadURL());
  // print("bro $catName");
  final fileRef = storageRef.child("$fileName$i.$ext");
  try {
    return await fileRef.getData().then((value) => cardImage = Image.memory(
          value!,
          width: MediaQuery.of(context).size.width,
          height: 1000,
          fit: BoxFit.fitWidth,
        ));
  } on FirebaseException catch (e) {
    // Handle any errors.
    print("Error $e!");
  }
  return Image.asset("images/test.jpeg");
}

//===================================================================================
/// Load categories fields from Firebase Database
StreamSubscription retrieveCategoryDB(dynamic fulfillCard,
    dynamic moveToCategory, dynamic moveToEditCategory, dynamic removeCard) {
  return FirebaseDatabase.instance.ref("categories").onValue.listen((event) {
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

StreamSubscription retrieveAllFavouriteFilesDB(dynamic fulfillCard,
    dynamic moveToFile, dynamic moveToEditFile, dynamic removeCard) {
  return FirebaseDatabase.instance.ref("files").onValue.listen((event) {
    List<Widget> tempCards = List.empty(growable: true);

    for (var cat in event.snapshot.children) {
      for (var el in cat.children) {
        //el.value contenuto di category{path:..., nfiles:...}
        final data =
            Map<String, dynamic>.from(el.value as Map<Object?, Object?>);

        FileModel cardFile = FileModel.fromRTDB(data);

        if (!cardFile.isFavourite) continue;

        //el.key nome di category
        final cardName = el.key.toString();

        //insert card in order
        tempCards.add(
          FileCard(cardName, cardFile, moveToFile, moveToEditFile, removeCard),
        );

        //   orders.insert(cardCat.order, cardCat.order);
        //   orders.removeAt(cardCat.order + 1);
      }
    }

    List<Widget> cards =
        List.generate(tempCards.length, (index) => Container());

    cards.addAll(tempCards);

    fulfillCard(cards);
  });
}

StreamSubscription retrieveAllFilesDB(dynamic fulfillCard, dynamic moveToFile,
    dynamic moveToEditFile, dynamic removeCard) {
  return FirebaseDatabase.instance.ref("files").onValue.listen((event) {
    int cardListSize = 0;
    for (var cat in event.snapshot.children) {
      cardListSize += cat.children.length;
    }

    List<Widget> cards = List.generate(cardListSize, (index) => Container());

    for (var cat in event.snapshot.children) {
      for (var el in cat.children) {
        //el.value contenuto di category{path:..., nfiles:...}
        final data =
            Map<String, dynamic>.from(el.value as Map<Object?, Object?>);

        FileModel cardFile = FileModel.fromRTDB(data);

        //el.key nome di category
        final cardName = el.key.toString();

        //insert card in order
        cards.add(
          FileCard(cardName, cardFile, moveToFile, moveToEditFile, removeCard),
        );

        //   orders.insert(cardCat.order, cardCat.order);
        //   orders.removeAt(cardCat.order + 1);
      }
    }
    fulfillCard(cards);
  });
}

StreamSubscription retrieveAllExpirationFilesDB(dynamic fulfillCard,
    dynamic moveToFile, dynamic moveToEditFile, dynamic removeCard) {
  return FirebaseDatabase.instance.ref("files").onValue.listen((event) {
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
/// Load files fields from Firebase Database
StreamSubscription retrieveFilesDB(String catName, dynamic fulfillCard,
    dynamic moveToFile, dynamic moveToEditFile, dynamic removeCard) {
  return FirebaseDatabase.instance
      .ref("files/$catName")
      .onValue
      .listen((event) {
    List<Widget> cards =
        List.generate(event.snapshot.children.length, (index) => Container());
    /*   List<int> orders =
        List.generate(event.snapshot.children.length, ((index) => 0));*/
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

      //   orders.insert(cardCat.order, cardCat.order);
      //   orders.removeAt(cardCat.order + 1);
    }
    fulfillCard(cards);
  });
}

//===================================================================================
/// Return all categories names
StreamSubscription retrieveCategoriesNamesDB(dynamic fillCategoriesNames) {
  return FirebaseDatabase.instance.ref("categories").onValue.listen((event) {
    List<String> list = [];
    for (var el in event.snapshot.children) {
      //el.key nome di category
      list.add(el.key.toString());
      //fillCategoriesNames(el.key.toString());
    }
    fillCategoriesNames(list);
  });
}

//===================================================================================
/// Return for the category color
StreamSubscription getColorCategory(dynamic setColor, String catName) {
  return FirebaseDatabase.instance
      .ref("categories/$catName")
      .onValue
      .listen((event) {
    final data = Map<String, dynamic>.from(
        event.snapshot.value as Map<Object?, Object?>);
    final cardCat = CategoryModel.fromRTDB(data);
    setColor(cardCat.colorValue);
  });
}

//===================================================================================
//TODO
/*StreamSubscription retrievePreviewListFromFileNameDB(
    String fileName, dynamic setList) {
  return FirebaseDatabase.instance
      .ref("allFiles/$fileName")
      .onValue
      .listen((event) {
    final data = Map<String, dynamic>.from(
        event.snapshot.value as Map<Object?, Object?>);

    FileModel cardFile = FileModel.fromRTDB(data);
    List<Widget> list = [];
    for (var element in cardFile.path) {
      int index = cardFile.path.indexOf(element);
      Image img= ;
      list.add(DocumentPreview(
          img, MediaQuery.of(context).size.width * 0.9, removeImage));
    }

    setList(list);
  });
}*/
//===================================================================================
retrieveFileDataFromFileNameDB(String fileName, dynamic setFileData) {
  return FirebaseDatabase.instance
      .ref("allFiles/$fileName")
      .onValue
      .listen((event) {
    final data = Map<String, dynamic>.from(
        event.snapshot.value as Map<Object?, Object?>);

    FileModel cardFile = FileModel.fromRTDB(data);
    setFileData(cardFile);
  });
}
