import 'dart:async';

import 'package:docs_manager/backend/models/category.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//===================================================================================
/// Update order value on Firebase Database
updateOrderDB(int index, String catName) async {
  final dbRef = FirebaseDatabase.instance.ref("categories/$catName");
  await dbRef.update({"order": index});
}

//===================================================================================
/// Update nfiles value on Firebase Database
onUpdateNFiles(String nameCat) {
  FirebaseDatabase.instance.ref("files/$nameCat").onValue.listen((event) {
    //load num of files
    FirebaseDatabase.instance
        .ref("categories/$nameCat")
        .update({
          "nfiles": event.snapshot.children.length,
        })
        .then((value) => print("Nfiles updated!"))
        .catchError((error) => print("An error occured!"));
  });
}

//===================================================================================
/// Update favourite value on Firebase Database
updateFavouriteDB(String nameCat, String nameFile, bool value) async {
  final dbRef = FirebaseDatabase.instance.ref("files/$nameCat/$nameFile");
  await dbRef.update({"isFavourite": value});
}
//===================================================================================

/// Upload categories for editing to Firebase Database
updateCategoryDB(String name, CategoryModel cat) async {
  var categories = FirebaseDatabase.instance.ref("categories");
  var newCategory = categories.child(name);

  await newCategory
      .update({
        "path": cat.path,
        "nfiles": cat.nfiles,
        "order": cat.order,
        "colorValue": cat.colorValue,
      })
      .then((value) => print("Category created!"))
      .catchError((error) => print("An error occured!"));
}
//===================================================================================