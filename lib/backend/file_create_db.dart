import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;
//===================================================================================
// Upload categories fields to Firebase Database
import 'package:firebase_database/firebase_database.dart';

createFile(String nameCat, String nameFile, path) async {
  var catRef = FirebaseDatabase.instance.ref("files/$nameCat");
  var fileRef = catRef.child(nameFile);
  int length = 0;

  await fileRef
      .update({
        "path": path,
      })
      .then((value) => print("File created!"))
      .catchError((error) => print("An error occured!"));

  //s.cancel();
}
//===================================================================================