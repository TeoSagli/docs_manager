import 'dart:async';

import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//===================================================================================
/// Update order value on Firebase Database
updateOrderDB(int index, String catName) async {
  var key = userRefDB();
  var userPath = "users/$key";
  final dbRef = FirebaseDatabase.instance.ref("$userPath/categories/$catName");
  await dbRef.update({"order": index});
}

//===================================================================================
/// Update nfiles value on Firebase Database
onUpdateNFiles(String nameCat) {
  var key = userRefDB();
  var userPath = "users/$key";
  FirebaseDatabase.instance
      .ref("$userPath/files/$nameCat")
      .onValue
      .listen((event) {
    //load num of files
    FirebaseDatabase.instance
        .ref("$userPath/categories/$nameCat")
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
  var key = userRefDB();
  var userPath = "users/$key";
  final dbRef =
      FirebaseDatabase.instance.ref("$userPath/files/$nameCat/$nameFile");
  await dbRef.update({"isFavourite": value});
  final dbRef2 = FirebaseDatabase.instance.ref("$userPath/allFiles/$nameFile");
  await dbRef2.update({"isFavourite": value});
}
//===================================================================================

/// Upload categories for editing to Firebase Database
updateCategoryDB(String name, CategoryModel cat) async {
  var key = userRefDB();
  var userPath = "users/$key";
  var categories = FirebaseDatabase.instance.ref("$userPath/categories");
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