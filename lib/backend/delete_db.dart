//===================================================================================
import 'package:docs_manager/backend/read_db.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DeleteDB {
//===================================================================================
  /// Delete a category [catName] on Firebase Database
  deleteCategoryDB(String catName) async {
    var key = ReadDB().userRefDB();
    var userPath = "users/$key";
    await FirebaseDatabase.instance.ref("$userPath/files/$catName").remove();
    await FirebaseDatabase.instance
        .ref("$userPath/categories/$catName")
        .remove();
  }

//===================================================================================
  /// Delete a category [catName] on Firebase Storage
  deleteCategoryStorage(String catPath, String catName) async {
    var key = ReadDB().userRefDB();
    var userPath = "users/$key";
    await FirebaseStorage.instance
        .ref("$userPath/categories/$catPath")
        .delete();
  }

//===================================================================================
  /// Delete a file [fileName] on Firebase Database
  deleteFileDB(String catName, String fileName) async {
    var key = ReadDB().userRefDB();
    var userPath = "users/$key";
    await FirebaseDatabase.instance
        .ref("$userPath/files/$catName/$fileName")
        .remove();
    await FirebaseDatabase.instance
        .ref("$userPath/allFiles/$fileName")
        .remove();
  }

//===================================================================================
  /// Delete a file [fileName] on Firebase Storage
  deleteFileStorage(List<Object?> ext, String catName, String fileName) async {
    var key = ReadDB().userRefDB();
    var userPath = "users/$key";
    var refInstance = FirebaseStorage.instance.ref("$userPath/files/$catName/");
    int i = 0;
    for (var element in ext) {
      String fileExt = element as String;
      refInstance.child("$fileName$i.$fileExt").delete();
      i++;
    }
  }
//===================================================================================
}
