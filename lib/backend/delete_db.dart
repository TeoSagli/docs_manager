//===================================================================================
import 'package:docs_manager/backend/read_db.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

//===================================================================================
/// remove a category on Firebase Database
deleteCategoryDB(String catName) async {
  var key = userRefDB();
  var userPath = "users/$key";
  await FirebaseDatabase.instance.ref("$userPath/files/$catName").remove();
  await FirebaseDatabase.instance.ref("$userPath/categories/$catName").remove();
}

//===================================================================================
/// remove a category on Firebase Storage
deleteCategoryStorage(String catPath, String catName) async {
  var key = userRefDB();
  var userPath = "users/$key";
  await FirebaseStorage.instance.ref("$userPath/categories/$catPath").delete();
}

//===================================================================================
/// remove a file on Firebase Database
deleteFileDB(String catName, String fileName) async {
  var key = userRefDB();
  var userPath = "users/$key";
  await FirebaseDatabase.instance
      .ref("$userPath/files/$catName/$fileName")
      .remove();
  await FirebaseDatabase.instance.ref("$userPath/allFiles/$fileName").remove();
}

//===================================================================================
/// remove a file on Firebase Storage
deleteFileStorage(List<Object?> ext, String catName, String fName) async {
  var key = userRefDB();
  var userPath = "users/$key";
  for (var element in ext) {
    int i = ext.indexOf(element);
    await FirebaseStorage.instance
        .ref("$userPath/files/$catName/$fName$i.${element.toString()}")
        .delete();
  }
}
//===================================================================================