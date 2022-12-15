import 'dart:async';

import 'package:docs_manager/frontend/components/category_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'models/category.dart';

//===================================================================================
// Load categories images from Firebase Storage
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
// Load categories fields from Firebase Database
StreamSubscription retrieveCategoryDB(
    dynamic fullfilCard, dynamic moveToCategory) {
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
      //update cards list
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
    fullfilCard(cards, orders);
  });
}

//===================================================================================
// Return all categories names
StreamSubscription retrieveCategoriesNamesDB(dynamic fillCategoriesNames) {
  return FirebaseDatabase.instance.ref("categories").onValue.listen((event) {
    for (var el in event.snapshot.children) {
      //el.key nome di category
      fillCategoriesNames(el.key.toString());
    }
  });
}
