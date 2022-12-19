//===================================================================================
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

//===================================================================================
/// remove a category on Firebase Database
deleteCategoryDB(String catName) async {
  await FirebaseDatabase.instance.ref("files/$catName").remove();
  await FirebaseDatabase.instance.ref("categories/$catName").remove();
}

//===================================================================================
/// remove a category on Firebase Storage
deleteCategoryStorage(String catPath, String catName) async {
  await FirebaseStorage.instance.ref("categories/$catPath").delete();
  // await FirebaseStorage.instance.ref("files/$catName").delete();
}
//===================================================================================