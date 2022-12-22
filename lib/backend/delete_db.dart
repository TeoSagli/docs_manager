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
/// remove a file on Firebase Database
deleteFileDB(String catName, String fileName) async {
  await FirebaseDatabase.instance.ref("files/$catName/$fileName").remove();
  await FirebaseDatabase.instance.ref("allFiles/$fileName").remove();
}

//===================================================================================
/// remove a file on Firebase Storage
deleteFileStorage(List<Object?> fileNameList, String catName) async {
  for (var element in fileNameList) {
    await FirebaseStorage.instance
        .ref("files/$catName/${element.toString()}")
        .delete();
  }
}
//===================================================================================