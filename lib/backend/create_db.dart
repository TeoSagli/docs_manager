import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

//===================================================================================
/// Upload images to Firebase Storage
StreamSubscription loadFileToStorage(
    String fPath, String catName, String saveName, String nameRef) {
  final file = File(fPath);
  // Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref(nameRef);
// Upload file and metadata to the path 'images/mountains.jpg'
  final uploadTask = storageRef.child(saveName).putFile(file);
// Listen for state changes, errors, and completion of the upload.
  return uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
    switch (taskSnapshot.state) {
      case TaskState.running:
        final progress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        print("Upload is $progress% complete.");
        break;
      case TaskState.paused:
        print("Upload is paused.");
        break;
      case TaskState.canceled:
        print("Upload was canceled");
        break;
      case TaskState.error:
        // Handle unsuccessful uploads
        break;
      case TaskState.success:
        // Handle successful uploads on complete
        // ...
        break;
    }
  });
}

//===================================================================================
/// Upload categories fields to Firebase Database
createCategory(name, path) async {
  var categories = FirebaseDatabase.instance.ref("categories");
  var newCategory = categories.child(name);
  int length = 0;

  await categories
      .get()
      .asStream()
      .forEach((element) => length = element.children.length);

  await newCategory
      .update({
        "path": path,
        "nfiles": 0,
        "order": length,
        "colorValue": Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0)
            .value
      })
      .then((value) => print("Category created!"))
      .catchError((error) => print("An error occured!"));
}

//===================================================================================
/// Upload file fields to Firebase Database
createFile(
    String nameCat, String nameFile, String expiration, path, ext) async {
  var catRef = FirebaseDatabase.instance.ref("files/$nameCat");
  var fileRef = catRef.child(nameFile);
  await fileRef
      .update({
        "path": path,
        "categoryName": nameCat,
        "isFavourite": false,
        "expiration": expiration,
        "dateUpload": DateTime.now().toString(),
        "extension": ext,
      })
      .then((value) => print("File created!"))
      .catchError((error) => print("An error occured!"));

  createListOfAllFile(nameCat, nameFile, expiration, path, ext);
}

//===================================================================================
/// Upload all files list to Firebase Database
createListOfAllFile(
    String nameCat, String nameFile, String expiration, path, ext) async {
  var catRef = FirebaseDatabase.instance.ref("allFiles/");
  var fileRef = catRef.child(nameFile);
  await fileRef
      .update({
        "path": path,
        "categoryName": nameCat,
        "isFavourite": false,
        "expiration": expiration,
        "dateUpload": DateTime.now().toString(),
        "extension": ext,
      })
      .then((value) => print("File created!"))
      .catchError((error) => print("An error occured!"));
}
//===================================================================================