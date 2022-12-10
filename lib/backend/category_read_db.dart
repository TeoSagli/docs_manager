import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'models/category.dart';

//===================================================================================
// Load categories images from Firebase Storage
Future<Image> readImageCategoryStorage(String catName, Widget cardImage) async {
  final storageRef = FirebaseStorage.instance.ref("categories");
  // print(await storageRef.child("Pictures.png").getDownloadURL());
  // print("bro $catName");
  final catRef = storageRef.child(catName);

  try {
    const oneMegabyte = 1024 * 1024;

    return await catRef
        .getData(oneMegabyte)
        .then((value) => cardImage = Image.memory(
              value!,
              width: 100,
              height: 100,
              fit: BoxFit.fitWidth,
            ));

    // Data for "images/island.jpg" is returned, use this as needed.
  } on FirebaseException catch (e) {
    // Handle any errors.
    print("Error $e!");
  }
  return Image.asset(
    "images/test.png",
    width: 100,
    height: 100,
  );
}

//===================================================================================
// Load categories fields from Firebase Database
listCategoryStorage(dynamic fullfillCard) {
  print("InitState called");
  final dbRef = FirebaseDatabase.instance.ref("categories");
  dbRef.get().asStream().forEach((element) {
    for (var el in element.children) {
      //el.value contenuto di category{path:..., nfiles:...}
      final data = Map<String, dynamic>.from(el.value as Map<String, dynamic>);
      //el.key nome di category
      fullfillCard(el.key.toString(), Category.fromRTDB(data));
    }
  });
}
//===================================================================================