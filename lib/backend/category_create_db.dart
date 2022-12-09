import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;

createCategory(name, path) async {
  var newCategory = FirebaseDatabase.instance.ref("categories/$name");
  await newCategory
      .update({
        "path": path,
        "nfiles": 0,
        "colorValue": Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0)
            .value
      })
      .then((value) => print("Category created!"))
      .catchError((error) => print("An error occured!"));
}

loadFileToStorage(XFile? image, String catName) async {
  final fPath = image!.path;
  final fName = image.name;
  print("Dentro");
  Directory documentDirectory = await getApplicationDocumentsDirectory();

  print("$documentDirectory/$fName");
  print(fPath);
  final file = File(fPath);

// Create the file metadata
  final metadata = SettableMetadata(contentType: "image/jpg");

// Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref("categories");

// Upload file and metadata to the path 'images/mountains.jpg'
  final uploadTask = storageRef.child(catName).putFile(file, metadata);

// Listen for state changes, errors, and completion of the upload.
  uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
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


/*
loadFileToStorage(XFile? file) async {
  if (file == null) return;
  String imgUrl = '';
  Reference firebaseStorageRoot = FirebaseStorage.instance.ref();
  Reference referenceCategories = firebaseStorageRoot.child('images');

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference referenceImageToUpload = referenceCategories.child(uniqueFileName);

  try {
    //Store the file
    referenceImageToUpload.putFile(File(file.path));
    //print(await referenceImageToUpload.getDownloadURL());
    imgUrl = await referenceImageToUpload.getDownloadURL();
    print(imgUrl);
  } catch (error) {
    print("Error: $error!");
  }
}

*/