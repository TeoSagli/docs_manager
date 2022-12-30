import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:firebase_database/firebase_database.dart';

//===================================================================================
/// Update order value of category [catName] on Firebase Database
updateOrderDB(int index, String catName) async {
  var key = userRefDB();
  var userPath = "users/$key";
  final dbRef = FirebaseDatabase.instance.ref("$userPath/categories/$catName");
  await dbRef.update({"order": index});
}

//===================================================================================
/// Update nfiles value of category [catName] on Firebase Database
onUpdateNFilesDB(String catName) {
  var key = userRefDB();
  var userPath = "users/$key";
  FirebaseDatabase.instance
      .ref("$userPath/files/$catName")
      .onValue
      .listen((event) {
    //load num of files
    FirebaseDatabase.instance
        .ref("$userPath/categories/$catName")
        .update({
          "nfiles": event.snapshot.children.length,
        })
        .then((value) => print("Nfiles updated!"))
        .catchError((error) => print("An error occured!"));
  });
}

//===================================================================================
/// Update favourite value of file [fileName] on Firebase Database
updateFavouriteDB(String catName, String fileName, bool value) async {
  var key = userRefDB();
  var userPath = "users/$key";
  final dbRef =
      FirebaseDatabase.instance.ref("$userPath/files/$catName/$fileName");
  await dbRef.update({"isFavourite": value});
  final dbRef2 = FirebaseDatabase.instance.ref("$userPath/allFiles/$fileName");
  await dbRef2.update({"isFavourite": value});
}

//===================================================================================
/// Upload category [catName] for editing to Firebase Database
updateCategoryDB(String catName, CategoryModel cat) async {
  var key = userRefDB();
  var userPath = "users/$key";
  var categories = FirebaseDatabase.instance.ref("$userPath/categories");
  var newCategory = categories.child(catName);

  await newCategory
      .update({
        "path": cat.path,
        "nfiles": cat.nfiles,
        "order": cat.order,
        "colorValue": cat.colorValue,
      })
      .then((value) => print("Category Updated!"))
      .catchError((error) => print("An error occured!"));
}
//===================================================================================