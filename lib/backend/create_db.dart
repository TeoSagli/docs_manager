import 'dart:async';
import 'dart:io';
import 'package:docs_manager/backend/read_db.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

//===================================================================================
/// Create file at [fPath] and send to Firebase Storage
StreamSubscription loadFileToStorage(
    String fPath, String catName, String saveName, String nameRef) {
  var key = userRefDB();
  var userPath = "users/$key";
  final file = File(fPath);
  // Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref("$userPath/$nameRef");
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
/// Create file as [fData] and send to Firebase Storage
StreamSubscription loadFileAssetToStorage(
    Uint8List fData, String catName, String saveName, String nameRef) {
  var key = userRefDB();
  var userPath = "users/$key";
  // Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref("$userPath/$nameRef");
// Upload file and metadata to the path 'images/mountains.jpg'
  final uploadTask = storageRef.child(saveName).putData(fData);
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
/// Create a new category [catName] and fill the data
createCategoryDB(String catName, String path) async {
  var key = userRefDB();
  var userPath = "users/$key";
  var categories = FirebaseDatabase.instance.ref("$userPath/categories");
  var newCategory = categories.child(catName);
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
/// Create default categories for new user
createDefaultCategoriesDB() async {
  var key = userRefDB();
  var userPath = "users/$key";
  List<Map<String, dynamic>> defCats = [
    {"name": "Credit Cards", "path": "Credit Cards.png", "col": 4282682111},
    {"name": "IDs", "path": "IDs.png", "col": 4285132974},
    {"name": "Other Cards", "path": "Other Cards.png", "col": 4294945600},
    {"name": "Documents", "path": "Documents.png", "col": 4294922834},
    {"name": "Pictures", "path": "Pictures.png", "col": 4292886779}
  ];

  var categories = FirebaseDatabase.instance.ref("$userPath/categories");

  for (Map<String, dynamic> defCat in defCats) {
    var newCategory = categories.child(defCat['name']);
    var i = defCats.indexOf(defCat);
    var bytes = (await rootBundle.load('assets/images/${defCat['path']}'))
        .buffer
        .asUint8List();
    StreamSubscription s = loadFileAssetToStorage(
        bytes, defCat['name'], defCat['path'], 'categories');
    await newCategory
        .update({
          "path": defCat['path'],
          "nfiles": 0,
          "order": i,
          "colorValue": defCat['col'],
        })
        .then((value) => print("Category default created!"))
        .catchError((error) => print("An error occured!"));
    s.cancel();
  }
}
//===================================================================================
/// Convert ele from Json

//===================================================================================
/// Create new user with [uid] in Firebase Database
createUserDB(String email, String uid) async {
  var newUser = FirebaseDatabase.instance.ref("users/$uid");

  await newUser
      .update({
        "email": email,
      })
      .then((value) => print("User created!"))
      .catchError((error) => print("An error occured creating user!"));
}

//===================================================================================
/// Create file [fileName] in Firebase Database
createFile(String catName, String fileName, String expiration, path, ext,
    String ref) async {
  var key = userRefDB();
  var userPath = "users/$key";
  var catRef = FirebaseDatabase.instance.ref("$userPath/$ref");
  var fileRef = catRef.child(fileName);
  await fileRef
      .update({
        "path": path,
        "categoryName": catName,
        "isFavourite": false,
        "expiration": expiration,
        "dateUpload": DateTime.now().toString(),
        "extension": ext,
      })
      .then((value) => print("File created!"))
      .catchError((error) => print("An error occured!"));
}

//===================================================================================
