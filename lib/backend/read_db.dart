import 'dart:async';

import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/category_card.dart';
import 'package:docs_manager/frontend/components/file_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'models/category.dart';

//===================================================================================
/// Load categories images from Firebase Storage
Future<Widget> readImageCategoryStorage(
    String catName, Widget cardImage) async {
  final storageRef = FirebaseStorage.instance.ref("categories");
  // print(await storageRef.child("Pictures.png").getDownloadURL());
  // print("bro $catName");
  final catRef = storageRef.child(catName);

  try {
    return await catRef.getData().then((value) => cardImage = Image.memory(
          value!,
          width: 100,
          height: 100,
          fit: BoxFit.fitWidth,
        ));

    // Data for "images/island.jpg" is returned, use this as needed.
    // Data for "images/island.jpg" is returned, use this as needed.
  } on FirebaseException catch (e) {
    // Handle any errors.
    print("Error $e!");
  }
  return Image.asset("images/test.jpeg");
}

//===================================================================================
/// Load files images from Firebase Storage
Future<Widget> readImageFileStorage(
    String filePath, String catName, String fileName, Widget cardImage) async {
  final storageRef = FirebaseStorage.instance.ref("files/$catName/$fileName");
  // print(await storageRef.child("Pictures.png").getDownloadURL());
  // print("bro $catName");
  final fileRef = storageRef.child(filePath);
  try {
    return await fileRef.getData().then((value) => cardImage = Image.memory(
          value!,
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
StreamSubscription retrieveCategoryDB(
    dynamic fulfillCard, dynamic moveToCategory) {
  return FirebaseDatabase.instance.ref("categories").onValue.listen((event) {
    List<Container> cards =
        List.generate(event.snapshot.children.length, (index) => Container());
    List<int> orders =
        List.generate(event.snapshot.children.length, ((index) => 0));
    for (var el in event.snapshot.children) {
      //el.value contenuto di category{path:..., nfiles:...}
      final data = Map<String, dynamic>.from(el.value as Map<Object?, Object?>);
      final cardCat = Category.fromRTDB(data);
      //el.key nome di category
      final cardName = el.key.toString();

      //insert card in order
      cards.insert(
          cardCat.order,
          Container(
            key: Key(cardCat.order.toString()),
            child: CategoryCard(cardName, cardCat, moveToCategory),
          ));

      orders.insert(cardCat.order, cardCat.order);
      cards.removeAt(cardCat.order + 1);
      orders.removeAt(cardCat.order + 1);
    }
    fulfillCard(cards, orders);
  });
}

//===================================================================================
/// Load files fields from Firebase Database
StreamSubscription retrieveFilesDB(
    String catName, dynamic fulfillCard, dynamic moveToFile) {
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

      File cardFile = File.fromRTDB(data);

      //el.key nome di category
      final cardName = el.key.toString();

      //insert card in order
      cards.add(
        FileCard(cardName, cardFile, moveToFile),
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
    for (var el in event.snapshot.children) {
      //el.key nome di category
      fillCategoriesNames(el.key.toString());
    }
  });
}

//===================================================================================
/// Return for a category the number of files in it
int retrieveNFilesCategoryDB(String catName) {
  int nfiles = 0;

  return nfiles;
}
//===================================================================================