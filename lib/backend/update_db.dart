import 'package:firebase_database/firebase_database.dart';

import 'models/category.dart';

//===================================================================================
/// Update order value on Firebase Database
updateOrderDB(int index, String catName) async {
  final dbRef = FirebaseDatabase.instance.ref("categories/$catName");
  await dbRef.update({"order": index});
}

//===================================================================================
/// Update nfiles value on Firebase Database
onUpdateNFiles(String nameCat) {
  return FirebaseDatabase.instance
      .ref("files/$nameCat")
      .onValue
      .listen((event) {
    //load num of files
    FirebaseDatabase.instance
        .ref("categories/$nameCat")
        .update({
          "nfiles": event.snapshot.children.length,
        })
        .then((value) => print("Nfiles updated!"))
        .catchError((error) => print("An error occured!"));
  });
}
//===================================================================================d